//
//  UITableViewCellSetupUtility.swift
//
//  Copyright © 2023 Manju Kiran. All rights reserved.
//

import XCTest
import UIKit
@testable import Lloyds_Exercise

class UITableViewCellSetupUtility<T: UITableViewCell> : NSObject {
       
    class func setupTopLevelUI(withCell cell: T.Type) -> T? {
        let nibFile = Bundle.main.loadNibNamed(T.reuseIdentifier, owner: self, options: nil)
        if let cell = nibFile?.first as? T {
            return cell
        }
        return nil
    }
    
}
