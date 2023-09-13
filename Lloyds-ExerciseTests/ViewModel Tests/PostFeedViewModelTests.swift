//
//  PostFeedViewModelTests.swift
//
//  Copyright © 2023 Manju Kiran. All rights reserved.
//

import XCTest
import UIKit
@testable import Lloyds_Exercise

class PostFeedViewModelTests: XCTestCase {
    var sut: PostFeedViewModel!
    fileprivate var mockPostFeedViewModelDelegate: MockPostFeedViewModelDelegate!

    override func setUp() {
        guard
            let postsListData = try? DataUtility.postListJSONData(),
            let usersListData = try? DataUtility.userListJSONData()
        else { XCTFail() ; return }

        let mockResponsesDict: [String: Data] = [
            APIEndpoint.posts.urlString: postsListData,
            APIEndpoint.users.urlString: usersListData
        ]
        let dataFetcher = NetworkMockUtility.SuccessfulNetworkFetch(data: mockResponsesDict)
        mockPostFeedViewModelDelegate = MockPostFeedViewModelDelegate()

        sut = PostFeedViewModel(networkDataManager: dataFetcher)
        sut.delegate = mockPostFeedViewModelDelegate

    }


    func test_FetchingPostsListData_FromBackend_returnsSuccess() async {
        XCTAssertEqual(sut.fetchState, .inactive, "sut.fetchState must be .inactive before fetch")
        let result = await sut.fetchData()
        XCTAssertEqual(sut.count, 100)
        XCTAssertEqual(result, .success, "sut.fetchState must be .success after fetch")
    }

    func test_NumberOfRowsInSection_0_returns_100_rows_whenFetchSuccess() async {
        XCTAssertEqual(sut.fetchState, .inactive, "sut.fetchState must be .inactive before fetch")
        let result = await sut.fetchData()
        XCTAssertEqual(sut.numberOfRowsIn(section: 0), 100)
        XCTAssertEqual(result, .success, "sut.fetchState must be .success after fetch")
    }

    func test_NumberOfRowsInSection_0_returns_1_row_whenFetchFails() async {
        let dataFetcher = NetworkMockUtility.SuccessfulNetworkFetch(data: [:])
        self.sut = PostFeedViewModel(networkDataManager: dataFetcher)
        let result = await sut.fetchData()
        XCTAssertEqual(sut.numberOfRowsIn(section: 0), 1) // Placeholder
        XCTAssertEqual(result, .fail(error: DownloadError.serverError), "sut.fetchState must be .fail after fetch fails")
    }

    func test_didSelectRow_atIndexPath_0_0_callsDelegate_WithFirstPost() async throws {
        let _ = await sut.fetchData()
        guard let postsList = try? JSONUtility.decodePostListFromJson(),
              let firstPost = postsList.first else {
            XCTFail("Unable to get post data to run asserts for")
            return
        }
        let expectation = XCTestExpectation(description: "mockPostFeedViewModelDelegate callback should be called")
        mockPostFeedViewModelDelegate.navigateToCommentsViewCallback = { post in
            XCTAssertEqual(firstPost.id, post.id)
            expectation.fulfill()
        }

        DispatchQueue.main.async { [weak self] in
            self?.sut.didSelectRow(at: IndexPath(row: 0, section: 0), in: UITableView())
        }
        wait(for: [expectation], timeout: 2.0)

    }
}

private class MockPostFeedViewModelDelegate: PostFeedViewModelDelegate {
    var postToFetchCommentsFor: Post?
    var navigateToCommentsViewCallback: ((Post) -> ())?

    func navigateToCommentsView(for post: Post) {
        postToFetchCommentsFor = post
        navigateToCommentsViewCallback?(post)
    }

}

