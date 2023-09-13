//
//  ContentViewControllerTests.swift
//
//  Copyright © 2023 Manju Kiran. All rights reserved.
//

import XCTest
@testable import Lloyds_Exercise

class ContentViewControllerTests: XCTestCase {
    
    private var rootViewController: ContentViewController!
    private var topLevelUIUtilities: TopLevelUIUtilities<ContentViewController>!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        guard
            let postsListData = try? DataUtility.postListJSONData(),
            let usersListData = try? DataUtility.userListJSONData()
        else { XCTFail() ; return }

        let mockResponsesDict: [String: Data] = [
            APIEndpoint.posts.urlString: postsListData,
            APIEndpoint.users.urlString: usersListData
        ]

        let dataFetcher = NetworkMockUtility.SuccessfulNetworkFetch(data: mockResponsesDict)
        let postFeedViewModel = PostFeedViewModel(networkDataManager: dataFetcher)
        Task {
            let _ = await postFeedViewModel.fetchData()
        }

        let myViewController = ContentViewController.create(postFeedViewModel)
        rootViewController = myViewController
        topLevelUIUtilities = TopLevelUIUtilities<ContentViewController>()
        topLevelUIUtilities.setupTopLevelUI(withViewController: rootViewController)
    }
    
    override func tearDown() {
        rootViewController = nil
        topLevelUIUtilities.tearDownTopLevelUI()
        topLevelUIUtilities = nil
        super.tearDown()
    }

    func test_load_postList_success_returns_correctValue_forNumberofCells() {
        let expectation = XCTestExpectation()
        UIView.runOnMainThread {
            XCTAssertEqual(rootViewController.tableView.numberOfRows(inSection: 0),
                           100)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3.0)
    }

    func testCell() {
        let expectation = XCTestExpectation()
        UIView.runOnMainThread {
            guard
                let sut = rootViewController.tableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? PostCell else {
                XCTFail("Unable to get `PostCell` instance from tableView")
                return
            }

            XCTAssertEqual(sut.titleLabel.text, "sunt aut facere repellat provident occaecati excepturi optio reprehenderit")
            XCTAssertEqual(sut.userNameLabel.text, "Bret")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3.0)
    }
}
