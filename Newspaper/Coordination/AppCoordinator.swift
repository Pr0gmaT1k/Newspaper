//
//  AppCoordinator.swift
//  Newspaper
//
//  Created by azerty on 04/10/2019.
//  Copyright © 2019 azerty. All rights reserved.
//

import UIKit

/** The application's root `Coordinator`. */

final class AppCoordinator: CoordinatorPresentable {
    
    var childCoordinators: [Coordinator] = []
    var rootViewController = UIViewController()
    
    init(window: UIWindow) {
        self.rootViewController.view.backgroundColor = .white
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
    
    func start() {
        if NPWebServiceClient.isLogged {
            let coordinator = FeedCoordinator()
            coordinator.delegate = self
            presentCoordinator(coordinator, animated: false)
            coordinator.start()
        } else {
            let coordinator = AuthCoordinator()
            coordinator.delegate = self
            presentCoordinator(coordinator, animated: false)
            coordinator.start()
        }
    }
}


// MARK: - Auth Coordinator Delegate
extension AppCoordinator: AuthCoordinatorDelegate {
    func authCoordinatorDidFinish(_ coordinator: AuthCoordinator) {
        dismissCoordinator(coordinator, animated: true)
        let feedcoordinator = FeedCoordinator()
        presentCoordinator(feedcoordinator, animated: true)
        feedcoordinator.delegate = self
    }
}


// MARK: - Feed Coordinator Delegate
extension AppCoordinator: FeedCoordinatorDelegate {
    func feedCoordinatorDidFinish(_ coordinator: FeedCoordinator) {}
}
