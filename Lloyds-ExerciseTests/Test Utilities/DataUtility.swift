//
//  DataUtility.swift
//
//  Copyright © 2023 Manju Kiran. All rights reserved.
//

import Foundation

final class DataUtility {

    private static func dataFromJSONFile(named fileName: String) throws -> Data {
        return try FileUtility.data(forFileName: fileName, withExtension: "json")
    }

    static func postListJSONData() throws -> Data {
        return try dataFromJSONFile(named: "PostList")
    }

    static func userListJSONData() throws -> Data {
        return try dataFromJSONFile(named: "UserList")
    }

    static func commentListJSONData() throws -> Data {
        return try dataFromJSONFile(named: "CommentList")
    }

}
