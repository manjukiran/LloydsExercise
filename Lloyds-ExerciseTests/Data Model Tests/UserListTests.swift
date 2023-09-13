//
//  UserListTests.swift
//
//  Copyright © 2023 Manju Kiran. All rights reserved.
//

import XCTest
@testable import Lloyds_Exercise

class UserListTests: XCTestCase {

    var sut: Users!
    
    override func setUp() {
        super.setUp()
        guard let sut = try? JSONUtility.decodeUserListFromJson() else {
            XCTFail("No users decoded")
            return
        }
        self.sut = sut
        XCTAssertEqual(self.sut.count, 10)
    }


    func testDecodedUser() {
        guard let user = self.sut.first else {
            XCTFail("No posts decoded")
            return
        }

        XCTAssertEqual(user.id, 1)
        XCTAssertEqual(user.name, "Leanne Graham")
        XCTAssertEqual(user.username, "Bret")
        XCTAssertEqual(user.email, "Sincere@april.biz")
        XCTAssertEqual(user.address.city, "Gwenborough")
        XCTAssertEqual(user.phone, "1-770-736-8031 x56442")
        XCTAssertEqual(user.website, "hildegard.org")
        XCTAssertEqual(user.company.name, "Romaguera-Crona")

    }

}
