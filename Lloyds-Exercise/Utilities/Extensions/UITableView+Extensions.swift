//
//  UITableView_Extensions.swift
//
//  Copyright © 2023 Manju Kiran. All rights reserved.
//

import UIKit

extension UITableView {
    
    func reloadOnMainThread() {
        UIView.runOnMainThread { [weak self] in
            self?.reloadData()
        }
    }
    
    func register<T : UITableViewCell>(cell: T.Type, nibName:String) {
        register(UINib.init(nibName: nibName, bundle: nil), forCellReuseIdentifier: cell.reuseIdentifier)
    }

    func deque<T: UITableViewCell>(with reuseIdentifier: String = T.reuseIdentifier,
                                   for indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: reuseIdentifier,
                                                  for: indexPath) as? T else {
            assertionFailure("Unable to deque \(T.reuseIdentifier) in tableView")
            return T()
        }
        return cell
    }
}
