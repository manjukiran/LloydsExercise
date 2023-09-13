//
//  String_Extensions.swift
//
//  Copyright © 2023 Manju Kiran. All rights reserved.
//

import UIKit

extension String {

    /// Utility to help access the localized string without having to type the lengthy NSLocalizedString(..:..) macro
    /// - Note: Using this will not help developer while using the usual `GENSTRINGS` command on `ternminal`.
    /// - It is imperative to ensure all strings are added to the Localizable.strings file
    ///
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
