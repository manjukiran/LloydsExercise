//
//  UITableViewCell.swift
//
//  Copyright © 2023 Manju Kiran. All rights reserved.
//

import UIKit

extension UIView {
    func parentView<T: UIView>(of type: T.Type) -> T? {
        guard let view = superview else {
            return nil
        }
        return (view as? T) ?? view.parentView(of: T.self)
    }
}

extension UITableViewCell {

    /// Simple utility to help access the reuse identifier of every cell class without having to rely on hardcoded strings
    public static var reuseIdentifier: String {
        return String(describing: self)
    }

    var tableView: UITableView? {
        return parentView(of: UITableView.self)
    }
}
