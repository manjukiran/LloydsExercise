//
//  MockedNetworkHandler.swift
//
//  Copyright © 2023 Manju Kiran. All rights reserved.
//

import Foundation

enum MockedNetworkTestingError: Error {
    case noMockedDataAvailable
    case other
}
public final class MockedNetworkHandler {

    public static func registerAndGenerateMockSession() -> URLSession {
        URLProtocol.registerClass(NetworkMockingURLProcotol.self)
        let configuration: URLSessionConfiguration = .ephemeral
        configuration.protocolClasses = [NetworkMockingURLProcotol.self]

        return URLSession(configuration: configuration)
    }

    public static func generateResponse(with data: Data? = nil) -> ((URLRequest) -> Result<NetworkMockingURLProcotol.ResponseData, Error>) {
        return { request in
            guard
                let url = request.url,
                let data = data
            else {
                assertionFailure("No mocked data available ")
                return .failure(MockedNetworkTestingError.noMockedDataAvailable)
            }

            let response = HTTPURLResponse(url: url,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)!

            return .success(NetworkMockingURLProcotol.ResponseData(response: response,
                                                                   data: data))
        }
        
    }

    private static func registerForUITesting(for urlString: String,
                                             with responseString: String) {
        NetworkMockingURLProcotol.responseProvider[urlString] = { request in
            guard
                let url = request.url,
                let data = responseString.data(using: .utf8)
            else {
                assertionFailure("No mocked data available ")
                return .failure(MockedNetworkTestingError.noMockedDataAvailable)
            }

            let response = HTTPURLResponse(url: url,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)!


            return .success(NetworkMockingURLProcotol.ResponseData(response: response,
                                                                   data: data))
        }
    }

}
