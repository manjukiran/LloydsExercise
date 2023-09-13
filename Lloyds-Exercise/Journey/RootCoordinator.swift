//
//  RootCoordinator.swift
//
//  Copyright © 2023 Manju Kiran. All rights reserved.
//

import UIKit.UIViewController

class RootCoordinator: Coordinating {

    var childCoordinators: [Coordinating] = []

    weak var window: UIWindow?
    var navigationController = UINavigationController()

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let postsViewModel = PostFeedViewModel(networkDataManager: NetworkDataUtility.shared)
        postsViewModel.delegate = self
        guard
            let window = self.window,
            let postViewController = ContentViewController.create(postsViewModel)else {
                assertionFailure("Unable to create ContentViewController")
                return
            }
        let navigationController = UINavigationController(rootViewController: postViewController)
        self.navigationController = navigationController
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    func terminate() {
        assertionFailure("Should only be called in child coordinators")
        // Do nothing
    }
}

extension RootCoordinator: PostFeedViewModelDelegate {

    func navigateToCommentsView(for post: Post) {
        let commentsViewModel = CommentsViewModel(post: post,
                                                  networkDataManager: NetworkDataUtility.shared)
        guard let commentsViewController = ContentViewController.create(commentsViewModel) else {
            assertionFailure("Unable to create ContentViewController")
            return
        }
        navigationController.pushViewController(commentsViewController,
                                                    animated: true)
    }

}
