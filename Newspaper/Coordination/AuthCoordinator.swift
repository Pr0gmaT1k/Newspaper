//
//  AuthCoordinator.swift
//  Newspaper
//
//  Created by azerty on 04/10/2019.
//  Copyright © 2019 azerty. All rights reserved.
//

import UIKit

// MARK: - Delegate
protocol AuthCoordinatorDelegate: class {
    func authCoordinatorDidFinish(_ coordinator: AuthCoordinator)
}

// MARK: - Coordinator
final class AuthCoordinator: CoordinatorNavigable {
    // MARK:- Properties
    weak var delegate: AuthCoordinatorDelegate?
    var childCoordinators: [Coordinator] = []
    var navigator: NavigatorType
    var rootViewController: UINavigationController
    
    init() {
        let authVC = StoryboardScene.Auth.authVC.instantiate()
        let navigationController = UINavigationController(rootViewController: authVC)
        navigationController.navigationBar.isHidden = true
        self.navigator = Navigator(navigationController: navigationController)
        self.rootViewController = navigationController
        self.rootViewController.modalPresentationStyle = .fullScreen
        self.rootViewController.modalTransitionStyle = .crossDissolve
        authVC.delegate = self
    }
    
    func start() {}
    
    func didTapBack() {
        self.rootViewController.popViewController(animated: true)
    }
}

// MARK:- AuthVC Delegate
extension AuthCoordinator: AuthVCDelegate {
    func didTapSignIn() {
        let vc = StoryboardScene.Auth.signInVC.instantiate()
        vc.delegate = self
        self.navigator.push(vc, animated: true)
    }
    
    func didTapSignUp() {
        let vc = StoryboardScene.Auth.signUpVC.instantiate()
        vc.delegate = self
        self.navigator.push(vc, animated: true)
    }
}

// MARK:- SIGNIN VC Delegate
extension AuthCoordinator: SignInVCDelegate {
    func didSignedIn() {
        delegate?.authCoordinatorDidFinish(self)
    }
}

// MARK:- SIGNUP VC Delegate
extension AuthCoordinator: SignUpVCDelegate {
    func didSignedUpAndIsSignedIn() {
        let vc = StoryboardScene.Auth.registeredVC.instantiate()
        vc.delegate = self
        self.navigator.push(vc, animated: true)
    }
}

// MARK:- Registered VC Delegate
extension AuthCoordinator: RegisteredVCDelegate {
    func didTapStartButton() {
        delegate?.authCoordinatorDidFinish(self)
    }
}
