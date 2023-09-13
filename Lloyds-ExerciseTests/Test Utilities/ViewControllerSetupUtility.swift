
//
//  ViewControllerSetupUtility.swift
//
//  Copyright © 2023 Manju Kiran. All rights reserved.
//

import XCTest
import UIKit

class TopLevelUIUtilities<T: UIViewController> {
    
    private var rootWindow: UIWindow!
    
    func setupTopLevelUI(withViewController viewController: T) {
        rootWindow = UIWindow(frame: UIScreen.main.bounds)
        rootWindow.isHidden = false
        rootWindow.rootViewController = viewController
        _ = viewController.view
        viewController.viewDidLoad()
        viewController.beginAppearanceTransition(true, animated: false)
    }
    
    func tearDownTopLevelUI() {
        guard let rootWindow = rootWindow,
            let rootViewController = rootWindow.rootViewController as? T else {
                XCTFail("tearDownTopLevelUI() was called without setupTopLevelUI() being called first")
                return
        }
        rootViewController.endAppearanceTransition()
        rootWindow.rootViewController = nil
        rootWindow.isHidden = true
        self.rootWindow = nil
    }
}
