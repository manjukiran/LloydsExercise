//
//  UIView_Extensions.swift
//
//  Copyright © 2023 Manju Kiran. All rights reserved.
//

import UIKit

extension UIView {
    
    /// UIView utility to ensure provided block runs on Main Thread
    ///
    /// - Parameter block: closure containing the code to run
    class func runOnMainThread(block: () -> ()) {
        if Thread.isMainThread {
            block()
            return
        }
        DispatchQueue.main.sync {
            block()
        }
    }
}
