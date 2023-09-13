//
//  SceneDelegate.swift
//
//  Copyright © 2023 Manju Kiran. All rights reserved.
//

import UIKit
import NetworkMockingSupport

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var appCoordinator: Coordinating?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        // Setup theme for our app
        setupAppTheme()

        let window = UIWindow(windowScene: windowScene)
        appCoordinator = RootCoordinator(window: window)
        appCoordinator?.start()
        self.window = window
    }

    private func setupAppTheme(){
        LETheme.applyTheme()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}
    func sceneDidBecomeActive(_ scene: UIScene) {}
    func sceneWillResignActive(_ scene: UIScene) {}
    func sceneWillEnterForeground(_ scene: UIScene) {}
    func sceneDidEnterBackground(_ scene: UIScene) {}
}

