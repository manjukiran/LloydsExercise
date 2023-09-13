//
//  Post.swift
//
//  Copyright © 2023 Manju Kiran. All rights reserved.
//

typealias Posts = [Post]

struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decode(Int.self, forKey: .userId)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.body = try container.decode(String.self, forKey: .body)
    }
}


