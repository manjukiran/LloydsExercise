//
//  AppDelegate.swift
//
//  Copyright © 2023 Manju Kiran. All rights reserved.
//

import UIKit
import NetworkMockingSupport

@main
class AppDelegate: UIResponder, UIApplicationDelegate, URLSessionProviding {

    // Like button on the post cell
    // Every time user taps on it, the like count increases by 1
    // 

    lazy private(set) var urlSession: URLSession = {
        guard CommandLine.arguments.contains("–-Testing") else {
            return URLSession(configuration: .default)
        }
        return MockedNetworkHandler.registerAndGenerateMockSession()
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

}

