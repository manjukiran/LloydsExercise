//
//  NMConstants
//
//  Copyright © 2023 Manju Kiran. All rights reserved.
//

import Foundation

/// URL String For Fetching JSON Data
public let baseURL = "https://jsonplaceholder.typicode.com/"

// MARK: - URL Constants

/// Individual Endpoints for each URL
enum APIEndpoint {
    case posts
    case users
    case comments(postId: Int)
    
    /// Returns the full URL String for the requested endpoint
    var urlString: String {
        let address: String
        switch self {
        case .posts:
            address = "posts"
        case .users:
            address = "users"
        case .comments(let postId):
            address = "posts/\(postId)/comments"
        }
        return baseURL + address
    }
    
}

// MARK: - Error Constants

/// String ENUMs to help guage the error code based on server response
enum DownloadError: String, Error {
    case badData = "Invalid Data"
    case redirectionError  = "Server Redirection error"
    case clientError = "Client unresponsive"
    case serverError = "Server Error"
    case invalidRequest = "Invalid Request"
    case unknownError = "Unknown Error"
    case appError = "App Programming Error"
}

enum ImageError: String, Error {
    case invalidRequest = "Invalid Request"
    case badImageData = "Invalid Image Data"
}

/// Intervals
public enum Intervals : TimeInterval {
    case networkTimeoutInterval  = 30.0
}
