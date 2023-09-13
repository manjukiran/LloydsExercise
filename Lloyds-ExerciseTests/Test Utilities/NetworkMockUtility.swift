//
//  NetworkMockUtility.swift
//
//  Copyright © 2023 Manju Kiran. All rights reserved.
//

import UIKit
@testable import Lloyds_Exercise

enum NetworkMockUtility {
    
    struct SuccessfulNetworkFetch : URLDataFetching {
        let data: [String: Data]
        
        func fetchDataWithURL(url: URL) async -> DataResult {
            guard let data = data[url.absoluteString] else {
                return .failure(DownloadError.serverError)
            }
            return .success(data)
        }

        func postDataWithURL(url: URL, body: Data) async -> Lloyds_Exercise.DataResult {
            guard let data = data[url.absoluteString] else {
                return .failure(DownloadError.serverError)
            }
            return .success(data)
        }
    }
}





