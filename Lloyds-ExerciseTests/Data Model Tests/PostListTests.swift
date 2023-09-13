//
//  PostListTest.swift
//
//  Copyright © 2023 Manju Kiran. All rights reserved.
//


import XCTest
@testable import Lloyds_Exercise

class PostListTest: XCTestCase {

    var sut: Posts!
    
    override func setUp() {
        super.setUp()
        guard let sut = try? JSONUtility.decodePostListFromJson() else {
            XCTFail("No posts decoded")
            return
        }
        self.sut = sut
        XCTAssertEqual(self.sut.count, 100)
    }


    func testDecodedPost() {
        guard let post = self.sut.first else {
            XCTFail("No posts decoded")
            return
        }
        XCTAssertEqual(post.userId, 1)
        XCTAssertEqual(post.id, 1)
        XCTAssertEqual(post.title, "sunt aut facere repellat provident occaecati excepturi optio reprehenderit")
        XCTAssertEqual(post.body, "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto")
    }

}
