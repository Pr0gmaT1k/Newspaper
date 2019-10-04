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
        authVC.delegate = self
    }
    
    func start() {}
    
    func backButtonDidTapped() {
        self.rootViewController.popViewController(animated: true)
    }
    
    private func signIn(email: String, pwd: String, completion: @escaping (_ sucess: Bool) -> Void) {
        wsClient.auth(email: email, pwd: pwd)
        .observeOn(MainScheduler.instance)
        .subscribe { event in
            switch event {
            case .completed: break
            case .error(let error):
                print(error)
                completion(false)
            case .next:
                completion(true)
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
    func signInButtonDidTap(email: String, pwd: String) {
        signIn(email: email, pwd: pwd) { sucess in
            if sucess {
                self.delegate?.authCoordinatorDidFinish(self)
            }
        }
    }
}

// MARK:- SIGNUP VC Delegate
extension AuthCoordinator: SignUpVCDelegate {
    func registerButtonDidTap(name: String,
                              lastName: String,
                              dni email: String,
                              email dni: String,
                              pwd: String,
                              pwdConfirmation: String) {
        wsClient.register(name: name, lastname: lastName, dni: dni, email: email, pwd: pwd, pwdConfimation: pwdConfirmation)
            .observeOn(MainScheduler.instance)
            .subscribe { event in
                switch event {
                case .completed: break
                case .error(let error): print(error)
                case .next:
                    let vc = StoryboardScene.Auth.registeredVC.instantiate()
                    vc.delegate = self
                    self.rootViewController.pushViewController(vc, animated: true)
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
