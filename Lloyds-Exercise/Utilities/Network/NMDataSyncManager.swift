//
//  NMDataSyncManager
//
//  Copyright © 2023 Manju Kiran. All rights reserved.
//

import UIKit.UIImage


/// Generic Data Fetch Result type; specify the type of the data to be decoded
typealias GenericDataFetchResult<T:Decodable>  = Result<T, DownloadError>

/**
 The primary utility for retrieving data from API and is utilized by all Models/View models. Its purpose is to fetch data and decode it into decodables.

 - This utility is designed generically, requiring the referring caller to provide the `type` of decodable object
 - An instance of this class is injected with a <URLDataFetching> object to facilitate testing.
 - Relies on the NetworkDataUtility class to fetch data through URLSession.
 */

class NMDataSyncManager {
    
    private let networkDataUtility: URLDataFetching
    required init(networkDataUtility: URLDataFetching){
        self.networkDataUtility  = networkDataUtility
    }

    /// Utilize the NMNetworkDataUtility class for API calls
    /// - Parameter urlString: URL of the API endpoint to hit
    /// - Returns: Result type with the decoded decoding native iOS object if successful.
    public func retrieveData<T: Decodable>(urlString: String) async -> GenericDataFetchResult<T> {
        guard let url = URL(string: urlString) else {
            return .failure(.invalidRequest)
        }
        let dataResult = await self.networkDataUtility.fetchDataWithURL(url: url)
        switch dataResult {
        case .success (let data) :
            return self.decode(data: data, type: T.self)
        case .failure (let error) :
            return (.failure(error))
        }
    }
    
    /// Used to decode the data retrieved from the API into the data object
    ///
    /// - Parameters:
    ///   - data: data retrieved from the API
    ///   - type: Class of the data to be decoded into
    /// - Returns: Swift 5 Result type -> either a (Success+DecodedData) *OR* (Failure+Error) tuple
    
    private func decode<T: Decodable>(data: Data, type: T.Type) -> Result<T,DownloadError> {
        let jsonDecoder = JSONDecoder()
        do {
            let decodedObject = try jsonDecoder.decode(T.self, from: data)
            return(.success(decodedObject))
        } catch let error {
            print (error.localizedDescription)
            return(.failure(.badData))
        }
    }
}
