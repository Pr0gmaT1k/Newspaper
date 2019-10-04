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
    
    typealias ViewController = UIViewController
    var childCoordinators: [Coordinator] = []
    var rootViewController: ViewController
    private var appWindow: UIWindow
    
    init(window: UIWindow) {
        appWindow = window
        if NPWebServiceClient.isLogged {
            let coordinator = FeedCoordinator()
            rootViewController = coordinator.rootViewController
            addChildCoordinator(coordinator)
            coordinator.start()
            appWindow.rootViewController = rootViewController
            coordinator.delegate = self
        } else {
            let coordinator = AuthCoordinator()
            rootViewController = coordinator.rootViewController
            addChildCoordinator(coordinator)
            coordinator.start()
            appWindow.rootViewController = rootViewController
            coordinator.delegate = self
        }
        window.makeKeyAndVisible()
    }
    
    func start() {}
}


// MARK: - Auth Coordinator Delegate
extension AppCoordinator: AuthCoordinatorDelegate {
    func authCoordinatorDidFinish(_ coordinator: AuthCoordinator) {
        dismissCoordinator(coordinator, animated: true)
        let feedCoordinator = FeedCoordinator()
        appWindow.rootViewController = feedCoordinator.rootViewController
        rootViewController = feedCoordinator.rootViewController
        addChildCoordinator(feedCoordinator)
        feedCoordinator.start()
    }
}


// MARK: - Feed Coordinator Delegate
extension AppCoordinator: FeedCoordinatorDelegate {
    func feedCoordinatorDidFinish(_ coordinator: FeedCoordinator) {}
}
