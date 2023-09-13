//
//  Coordinating.swift
//
//  Copyright © 2023 Manju Kiran. All rights reserved.
//

import UIKit

/// Currently we are only creating one coordinator as we only have two views to display
/// Once this coordination becomes more complex, we can migrate to having

protocol Coordinating: AnyObject {
    
    var childCoordinators: [Coordinating] { get set }
    var navigationController: UINavigationController { get set }

    /// Start the initial flow of the navigation
    func start()

    /// Complete the initial flow of the navigation
    func terminate()
}
