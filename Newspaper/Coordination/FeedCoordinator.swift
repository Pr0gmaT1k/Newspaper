//
//  FeedCoordinator.swift
//  Newspaper
//
//  Created by azerty on 04/10/2019.
//  Copyright © 2019 azerty. All rights reserved.
//

import UIKit
import RxSwift

// MARK: - Delegate

protocol FeedCoordinatorDelegate: class {
    func feedCoordinatorDidFinish(_ coordinator: FeedCoordinator, closeSession: Bool)
}

// MARK: - Coordinator

final class FeedCoordinator: CoordinatorNavigable {
    // MARK:- Properties
    private let bag = DisposeBag()
    private let wsClient = NPWebServiceClient()
    weak var delegate: FeedCoordinatorDelegate?
    var childCoordinators: [Coordinator] = []
    var navigator: NavigatorType
    var rootViewController: UINavigationController
    
    // MARK:- Func
    init() {
        let tabBarVC = StoryboardScene.Feed.tabBarVC.instantiate()
        let feedVC = StoryboardScene.Feed.feedVC.instantiate()
        let profileVC = StoryboardScene.Feed.profileVC.instantiate()
        let friendVC = StoryboardScene.Feed.friendVC.instantiate()
        tabBarVC.viewControllers = [feedVC, profileVC, friendVC]
        
        let navigationController = UINavigationController(rootViewController: tabBarVC)
        navigationController.navigationBar.isHidden = true
        navigator = Navigator(navigationController: navigationController)
        rootViewController = navigationController
        rootViewController.modalPresentationStyle = .fullScreen
        rootViewController.modalTransitionStyle = .crossDissolve
        
        feedVC.delegate = self
        profileVC.delegate = self
        friendVC.delegate = self
    }
    
    private func requestUser(completion: @escaping (User?) -> Void) {
        wsClient.user().observeOn(MainScheduler.instance)
        .subscribe { event in
            switch event {
            case .completed: break
            case .error(let error): print(error)
            case .next(let user): completion(user)
            }
        }.disposed(by: bag)
    }
    
    func start() {}
}

// MARK:- FeedVC Delegate
extension FeedCoordinator: FeedVCDelegate {
    func requestposts(vc: FeedVC) {
        wsClient.posts().observeOn(MainScheduler.instance)
        .subscribe { event in
            switch event {
            case .completed: break
            case .next(let posts): vc.updatePosts(posts: posts)
            case .error(let error): print(error)
            }
        }.disposed(by: bag)
    }
    
    func addpost() {
        
    }
}

// MARK:- ProfileVC Delegate
extension FeedCoordinator: ProfileVCDelegate {
    func closeSession() {
        wsClient.disconnect()
        delegate?.feedCoordinatorDidFinish(self, closeSession: true)
    }
    
    func requestUser(profileVC: ProfileVC) {
        requestUser { user in
            profileVC.fill(user: user)
        }
    }
}

// MARK:- FriendVC Delegate
extension FeedCoordinator: FriendVCDelegate {
    
}
