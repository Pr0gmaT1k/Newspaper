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
    // MARK:- Properties
    weak var delegate: FeedCoordinatorDelegate?
    var childCoordinators: [Coordinator] = []
    var navigator: NavigatorType
    var rootViewController: UINavigationController
    private var feedVCReference: FeedVC
    
    // MARK:- Func
    init() {
        let tabBarVC = StoryboardScene.Feed.tabBarVC.instantiate()
        let feedVC = StoryboardScene.Feed.feedVC.instantiate()
        let profileVC = StoryboardScene.Feed.profileVC.instantiate()
        let usersVC = StoryboardScene.Feed.usersVC.instantiate()
        tabBarVC.viewControllers = [feedVC, profileVC, usersVC]
        
        let navigationController = UINavigationController(rootViewController: tabBarVC)
        navigationController.navigationBar.isHidden = true
        navigator = Navigator(navigationController: navigationController)
        rootViewController = navigationController
        rootViewController.modalPresentationStyle = .fullScreen
        rootViewController.modalTransitionStyle = .crossDissolve
        feedVCReference = feedVC
        
        feedVC.delegate = self
        profileVC.delegate = self
        usersVC.delegate = self
    }
    
    func start() {}
    
    func didTapBack() {
        navigator.popViewController(animated: true)
    }
}

// MARK:- FeedVC Delegate
extension FeedCoordinator: FeedVCDelegate {
    func didTapAddPost() {
        let vc = StoryboardScene.Feed.createPostVC.instantiate()
        vc.delegate = self
        navigator.push(vc, animated: true)
    }
    
    func didSelect(post: Post) {
        let vc = StoryboardScene.Feed.detailsPostVC.instantiate()
        vc.delegate = self
        vc.post = post
        navigator.push(vc, animated: true)
    }
}

// MARK:- ProfileVC Delegate
extension FeedCoordinator: ProfileVCDelegate {
    func didClosedSession() {
        delegate?.feedCoordinatorDidFinish(self, closeSession: true)
    }
}

// MARK:- UsersVC Delegate
extension FeedCoordinator: UsersVCDelegate {}

// MARK:- CreatePost Delegate
extension FeedCoordinator: CreatePostVCDelegate {
    func didCreatePost() {
        navigator.popViewController(animated: true)
        feedVCReference.shouldRefresh = true
    }
}

// MARK:- DetailsPostVC Delegate
extension FeedCoordinator: DetailsPostVCDelegate {}
