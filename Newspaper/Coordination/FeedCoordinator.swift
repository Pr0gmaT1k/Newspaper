//
//  FeedCoordinator.swift
//  Newspaper
//
//  Created by azerty on 04/10/2019.
//  Copyright © 2019 azerty. All rights reserved.
//

import UIKit

// MARK: - Delegate

protocol FeedCoordinatorDelegate: class {
    func feedCoordinatorDidFinish(_ coordinator: FeedCoordinator)
}

// MARK: - Coordinator

final class FeedCoordinator: CoordinatorNavigable {
    weak var delegate: FeedCoordinatorDelegate?
    
    var childCoordinators: [Coordinator] = []
    var navigator: NavigatorType
    var rootViewController: UINavigationController
    
    init() {
        let feedVC = StoryboardScene.Feed.feedVC.instantiate()
        let navigationController = UINavigationController(rootViewController: feedVC)
        navigationController.navigationBar.isHidden = true
        self.navigator = Navigator(navigationController: navigationController)
        self.rootViewController = navigationController
        self.rootViewController.modalPresentationStyle = .fullScreen
        self.rootViewController.modalTransitionStyle = .crossDissolve
    }
    
    func start() {}
}
