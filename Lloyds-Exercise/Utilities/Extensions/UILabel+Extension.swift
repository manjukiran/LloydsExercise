//
//  UILabel_Extension.swift
//
//  Copyright © 2023 Manju Kiran. All rights reserved.
//

import UIKit.UILabel

extension UILabel {
    
    func configureFor(style: UIFont.TextStyle) {
        self.font = LETheme.shared.font(for: style)
        self.textColor = LETheme.shared.fontColor(for: style)
    }
    
}
