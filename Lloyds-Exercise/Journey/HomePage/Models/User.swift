//
//  User.swift
//
//  Copyright © 2023 Manju Kiran. All rights reserved.
//

typealias Users = [User]

// MARK: - User
struct User: Decodable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: Address
    let phone: String
    let website: String
    let company: Company

    // MARK: - Address
    struct Address: Decodable {
        let street: String
        let suite: String
        let city: String
        let zipcode: String
        let geo: Geo
    }

    // MARK: - Geo
    struct Geo: Decodable {
        let lat: String
        let lng: String
    }

    // MARK: - Company
    struct Company: Decodable {
        let name: String
        let catchPhrase: String
        let bs: String
    }

}



