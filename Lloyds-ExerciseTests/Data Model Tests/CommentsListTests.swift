//
//  CommentsListTests.swift
//
//  Copyright © 2023 Manju Kiran. All rights reserved.
//

import XCTest
@testable import Lloyds_Exercise

class CommentsListTests: XCTestCase {

    var sut: Comments!
    
    override func setUp() {
        super.setUp()
        guard let sut = try? JSONUtility.decodeCommentListFromJson() else {
            XCTFail("No comments decoded")
            return
        }
        self.sut = sut
        XCTAssertEqual(self.sut.count, 5)
    }


    func testDecodedComment() {
        guard let comment = self.sut.first else {
            XCTFail("No comment decoded")
            return
        }
        XCTAssertEqual(comment.id, 1)
        XCTAssertEqual(comment.postId, 1)
        XCTAssertEqual(comment.name, "id labore ex et quam laborum")
        XCTAssertEqual(comment.email, "Eliseo@gardner.biz")
        XCTAssertEqual(comment.body, "laudantium enim quasi est quidem magnam voluptate ipsam eos\ntempora quo necessitatibus\ndolor quam autem quasi\nreiciendis et nam sapiente accusantium")
    }

}
