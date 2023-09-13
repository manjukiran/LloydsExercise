//
//  Lloyds_ExerciseUITests.swift
//
//  Copyright © 2023 Manju Kiran. All rights reserved.
//

import XCTest

final class Lloyds_ExerciseUITests: UITestBaseClass {

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockData(for: "https://jsonplaceholder.typicode.com/posts",
                 with: try DataUtility.postListJSONData())
        mockData(for: "https://jsonplaceholder.typicode.com/users",
                 with: try DataUtility.userListJSONData())
        mockData(for: "https://jsonplaceholder.typicode.com/posts/1/comments",
                 with: try DataUtility.commentListJSONData())
    }


    func test_FirstScreen_Shows_PostsFeed() throws {
        // UI tests must launch the application that they test.
        app.launch()
        XCTAssert(app.staticTexts["Posts"].exists)
    }

    func test_PostsFeedScreen_TapOn_FirstCell_showsCommentsScreen() throws {
        // UI tests must launch the application that they test.
        app.launch()
        let firstPostCell = app.tables["GenericContentFeedTableView"].cells["GenericContentFeedTableViewCell_0_0"]

        XCTAssert(firstPostCell.exists)
        firstPostCell.tap()

        let commentPageTitlePredicate =  NSPredicate(format: "label BEGINSWITH 'sunt aut facere repellat'")
        let commentPageTitleLabel =  app.staticTexts.element(matching: commentPageTitlePredicate)

        let firstCommentCell = app.tables["GenericContentFeedTableView"].cells["GenericContentFeedTableViewCell_0_0"]

        XCTAssert(commentPageTitleLabel.waitForExistence(timeout: 5))
        XCTAssert(firstCommentCell.waitForExistence(timeout: 5))
    }

}


