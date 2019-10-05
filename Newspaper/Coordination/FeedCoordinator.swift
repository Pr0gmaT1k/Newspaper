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
    func feedCoordinatorDidFinish(_ coordinator: FeedCoordinator, closeSession: Bool)
}

// MARK: - Coordinator

final class FeedCoordinator: CoordinatorNavigable {
    weak var delegate: FeedCoordinatorDelegate?
    
    var childCoordinators: [Coordinator] = []
    var navigator: NavigatorType
    var rootViewController: UINavigationController
    
    init() {
        let tabBarVC = StoryboardScene.Feed.tabBarVC.instantiate()
        let feedVC = StoryboardScene.Feed.feedVC.instantiate()
        let profileVC = StoryboardScene.Feed.profileVC.instantiate()
        let friendVC = StoryboardScene.Feed.friendVC.instantiate()
        tabBarVC.viewControllers = [feedVC, profileVC, friendVC]
        
        let navigationController = UINavigationController(rootViewController: tabBarVC)
        navigationController.navigationBar.isHidden = true
        self.navigator = Navigator(navigationController: navigationController)
        self.rootViewController = navigationController
        self.rootViewController.modalPresentationStyle = .fullScreen
        self.rootViewController.modalTransitionStyle = .crossDissolve
        
        feedVC.delegate = self
        profileVC.delegate = self
        friendVC.delegate = self
    }
    
    func start() {}
}

// MARK:- FeedVC Delegate
extension FeedCoordinator: FeedVCDelegate {
    
}

// MARK:- ProfileVC Delegate
extension FeedCoordinator: ProfileVCDelegate {
    func closeSession() {
        
    }
    
    func requestUser() {
        
    }
}

// MARK:- FriendVC Delegate
extension FeedCoordinator: FriendVCDelegate {
    
}
