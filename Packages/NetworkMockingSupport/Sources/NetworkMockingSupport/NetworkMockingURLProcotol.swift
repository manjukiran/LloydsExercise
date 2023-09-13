//
//  UITestingURLProcotol.swift
//
//  Copyright © 2023 Manju Kiran. All rights reserved.
//

import Foundation

final public class NetworkMockingURLProcotol: URLProtocol {

    public override class func canInit(with request: URLRequest) -> Bool {
        guard
            let urlString = request.url?.absoluteString else {
            return false
        }

        if (Self.responseProvider[urlString] != nil) {
            // Unit testing
            return true
        }
        else if let response = ProcessInfo.processInfo.environment[urlString] {
            // UI Testing does not allow setting Mock responses directly, we have to leverage ProcessInfo and CommandLine arguments to source responses from
            Self.responseProvider[urlString] = MockedNetworkHandler.generateResponse(with: response.data(using: .utf8))
            return true
        }
        return false

    }

    public override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    public struct ResponseData {
        public let response: URLResponse
        public let data: Data
    }

    public static var responseProvider: [String : ((URLRequest) -> Result<ResponseData, Error>)] = [:]

    public override func startLoading() {
        guard
            let client,
            let urlString = request.url?.absoluteString else {
            fatalError()
        }

        if let responseProvider = Self.responseProvider[urlString] {
            switch responseProvider(request) {
            case .success(let responseData):
                client.urlProtocol(self, didReceive: responseData.response, cacheStoragePolicy: .notAllowed)
                client.urlProtocol(self, didLoad: responseData.data)
                client.urlProtocolDidFinishLoading(self)
            case .failure(let error):
                client.urlProtocol(self, didFailWithError: error)
                client.urlProtocolDidFinishLoading(self)
            }
        }
        else {
            let error = NSError(domain: "NetworkMockingURLProcotol", code: -1)
            client.urlProtocol(self, didFailWithError: error)
        }
    }

    public override func stopLoading() {}
}
