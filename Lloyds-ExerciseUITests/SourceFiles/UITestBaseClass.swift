//
//  UITestBaseClass.swift
//
//  Copyright © 2023 Manju Kiran. All rights reserved.
//

import XCTest

class UITestBaseClass: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        self.app = XCUIApplication()
        app.launchArguments += ["–-Testing"]
    }

    func mockData(for urlString: String, with data:Data) {
        app.launchEnvironment[urlString] = String(data: data, encoding: .utf8)
    }

}
