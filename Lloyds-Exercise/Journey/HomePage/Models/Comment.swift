//
//  Comment.swift
//
//  Copyright © 2023 Manju Kiran. All rights reserved.
//

typealias Comments = [Comment]

struct Comment: Codable {
    let id: Int
    let postId: Int
    let name: String
    let email: String
    let body: String
}
