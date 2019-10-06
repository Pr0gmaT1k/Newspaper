//
//  AuthCoordinator.swift
//  Newspaper
//
//  Created by azerty on 04/10/2019.
//  Copyright © 2019 azerty. All rights reserved.
//

import UIKit
import RxSwift

// MARK: - Delegate
protocol AuthCoordinatorDelegate: class {
    func authCoordinatorDidFinish(_ coordinator: AuthCoordinator)
}

// MARK: - Coordinator
final class AuthCoordinator: CoordinatorNavigable {
    // MARK:- Properties
    private let bag = DisposeBag()
    private let wsClient = NPWebServiceClient()
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
    
    func backButtonDidTapped() {
        self.rootViewController.popViewController(animated: true)
    }
    
    private func signIn(email: String, pwd: String, completion: @escaping (_ error: String?) -> Void) {
        wsClient.auth(email: email, pwd: pwd)
        .observeOn(MainScheduler.instance)
        .subscribe { event in
            switch event {
            case .completed: break
            case .error(let error): completion(error.localizedDescription)
            case .next: completion(nil)
            }
        }.disposed(by: bag)
    }
}

// MARK:- AuthVC Delegate
extension AuthCoordinator: AuthVCDelegate {
    func authVCSignInButtonDidTap() {
        let vc = StoryboardScene.Auth.signInVC.instantiate()
        vc.delegate = self
        self.navigator.push(vc, animated: true)
    }
    
    func authVCSignUpButtonDidTap() {
        let vc = StoryboardScene.Auth.signUpVC.instantiate()
        vc.delegate = self
        self.navigator.push(vc, animated: true)
    }
}

// MARK:- SIGNIN VC Delegate
extension AuthCoordinator: SignInVCDelegate {
    func signInButtonDidTap(email: String, pwd: String, vc: SignInVC) {
        signIn(email: email, pwd: pwd) { [unowned self] error in
            if let error = error {
                vc.displayError(error: error)
            } else {
                self.delegate?.authCoordinatorDidFinish(self)
            }
        }
    }
}

// MARK:- SIGNUP VC Delegate
extension AuthCoordinator: SignUpVCDelegate {
    func registerButtonDidTap(name: String,
                              lastName: String,
                              dni: String,
                              email: String,
                              pwd: String,
                              pwdConfirmation: String) {
        wsClient.register(name: name, lastname: lastName, dni: dni, email: email, pwd: pwd, pwdConfimation: pwdConfirmation)
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] event in
                switch event {
                case .completed: break
                case .error(let error): print(error)
                case .next:
                    self?.signIn(email: email, pwd: pwd) { error in
                        if let error = error {
                            // display error
                        } else {
                            let vc = StoryboardScene.Auth.registeredVC.instantiate()
                            vc.delegate = self
                            self?.navigator.push(vc, animated: true)
                        }
                    }
                }
        }.disposed(by: bag)
    }
}

// MARK:- Registered VC Delegate
extension AuthCoordinator: RegisteredVCDelegate {
    func startButtonTapped() {
        delegate?.authCoordinatorDidFinish(self)
    }
}
