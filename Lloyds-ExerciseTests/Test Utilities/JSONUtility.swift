//
//  JSONUtlity.swift
//
//  Copyright © 2023 Manju Kiran. All rights reserved.
//

import XCTest

@testable import Lloyds_Exercise

class JSONUtility {
    
    static let decoder = JSONDecoder()
    
    static func decodePostListFromJson() throws -> Posts? {
        return try decoder.decode(Posts.self, from: DataUtility.postListJSONData())
    }

    static func decodeUserListFromJson() throws -> Users? {
        return try decoder.decode(Users.self, from: DataUtility.userListJSONData())
    }

    static func decodeCommentListFromJson() throws -> Comments? {
        return try decoder.decode(Comments.self, from: DataUtility.commentListJSONData())
    }

}
