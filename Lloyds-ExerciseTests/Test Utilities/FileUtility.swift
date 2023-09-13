//
//  FileUtility.swift
//
//  Copyright © 2023 Manju Kiran. All rights reserved.
//

import UIKit

class FileUtility: NSObject {
    struct FileNotFoundError: Error {}
    
    static func data(forFileName fileName: String, withExtension fileExtension: String) throws -> Data {
        guard let url = Bundle(for: self).url(forResource: fileName,
                                              withExtension: fileExtension) else {
                                                throw FileNotFoundError()
        }
        return try Data(contentsOf: url)
    }}
