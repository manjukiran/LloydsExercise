//
//  NMNetworkDataUtility
//
//  Copyright © 2023 Manju Kiran. All rights reserved.
//

import UIKit.UIImage

typealias DataResult = Result<Data, DownloadError>

protocol URLDataFetching {
    func fetchDataWithURL(url: URL) async -> DataResult
    func postDataWithURL(url: URL, body: Data) async -> DataResult
}

/**
 
 Utility for retrieving data through GET requests from the Main Network API.
 
 - This utility is designed to be generic and relies on the calling class to provide the URL and a completion block.
 - Like the DataSyncManager, this class is implemented as a singleton to mitigate potential threading issues.
 */

class NetworkDataUtility: NSObject, URLDataFetching {

    static let shared = NetworkDataUtility()
    private var urlSession : URLSession?
    override private init() {
        super.init()
        self.urlSession = (UIApplication.shared.delegate as? URLSessionProviding)?.urlSession ??
        URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil)
    }

    
    /// Primary function of the class - uses URLSession to return data
    /// - Parameter url: URL formed based on the URL (Refer to the Constants class for the baseURL + API endpoint)
    /// - Returns: data result based on success / failure
    func fetchDataWithURL(url: URL) async -> DataResult {
        guard let urlSession = urlSession else {
            assertionFailure("urlSession not instantiated")
            return .failure(.appError)
        }
        var urlRequest = URLRequest(url: url,
                                    cachePolicy: .reloadIgnoringLocalCacheData,
                                    timeoutInterval: Intervals.networkTimeoutInterval.rawValue)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            let (data, response) = try await urlSession.data(from: url)
            guard let urlResponse = response as? HTTPURLResponse else {
                return .failure(.serverError)
            }
            if let responseError = self.handleNetworkResponse(response: urlResponse) {
                return .failure(responseError)
            }

            return .success(data)
        } catch {
            return .failure(.serverError)
        }
    }

    /// Primary function of the class - uses URLSession to return data
    /// - Parameter url: URL formed based on the URL (Refer to the Constants class for the baseURL + API endpoint)
    /// - Returns: data result based on success / failure
    func postDataWithURL(url: URL, body: Data) async -> DataResult {
        guard let urlSession = urlSession else {
            assertionFailure("urlSession not instantiated")
            return .failure(.appError)
        }
        var urlRequest = URLRequest(url: url,
                                    cachePolicy: .reloadIgnoringLocalCacheData,
                                    timeoutInterval: Intervals.networkTimeoutInterval.rawValue)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = body
        do {
            let (data, response) = try await urlSession.data(from: url)
            guard let urlResponse = response as? HTTPURLResponse else {
                return .failure(.serverError)
            }
            if let responseError = self.handleNetworkResponse(response: urlResponse) {
                return .failure(responseError)
            }

            return .success(data)
        } catch {
            return .failure(.serverError)
        }
    }
    
    
    /// Function to guage the response from the server
    ///
    /// - Parameter response: response received from the backend
    /// - Returns: optional error if the status is not 200..299
    private func handleNetworkResponse(response: HTTPURLResponse) -> DownloadError? {
        switch response.statusCode {
        case 200...299: return (nil)
        case 300...399: return (.redirectionError)
        case 400...499: return (.clientError)
        case 500...599: return (.serverError)
        case 600: return (.invalidRequest)
        default: return (.unknownError)
        }
    }
}

extension NetworkDataUtility : URLSessionDelegate {
    
    /// SSL Pinining Logic can be implemented here
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        // SSL Pinining Logic can be implemented here -> a certificate and a backup needs to be procured from the backned
        completionHandler(.useCredential,nil)
    }
}
