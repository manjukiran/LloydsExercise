//
//  UIViewController_Extensions.swift
//
//  Copyright © 2023 Manju Kiran. All rights reserved.
//

import UIKit

protocol StoryboardInstantiable: AnyObject {
    static var storyboardName: String { get }
    static func instantiate() -> Self?
}

extension StoryboardInstantiable {

    static var storyboardName: String {
        "Main"
    }

    static func instantiate() -> Self? {
        let fullName = NSStringFromClass(self)

        // this splits by the dot and uses everything after, giving ViewController.class
        let className = fullName.components(separatedBy: ".")[1]

        // load our storyboard
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)

        // instantiate a view controller with that identifier, and force cast as the type that was requested
        return storyboard.instantiateViewController(withIdentifier: className) as? Self
    }
}

extension UIViewController {
    
    /// Simple utility to help access the storyboard identifier of every view controller class without having to rely on hardcoded strings
    public static var storyboardIdentifier: String {
        return String(describing: self)
    }

}
