//
//  SignInVC.swift
//  Newspaper
//
//  Created by azerty on 03/10/2019.
//  Copyright © 2019 azerty. All rights reserved.
//

import UIKit
import RxSwift

// MARK:- Delegate
protocol SignInVCDelegate: class {
    func didSignedIn()
    func didTapBack()
}

// MARK:- Class
final class SignInVC: UIViewController {
    // MARK:- Properties
    private let bag = DisposeBag()
    private let wsClient = NPWebServiceClient()
    weak var delegate: SignInVCDelegate?
    
    // MARK:- IBOutlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var signInButton: UIButton!
    
    // MARK:- IBActions
    @IBAction func showPwdDidTouch(_ sender: Any) {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
    }
    
    @IBAction func backButtonDidTouch(_ sender: Any) {
        delegate?.didTapBack()
    }
    
    @IBAction func signInButtonDidTouch(_ sender: Any) {
        guard let email = emailTextField.text, let pwd = passwordTextField.text else { return }
        signIn(email: email, pwd: pwd)
    }
    
    // MARK:- Funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        // Label
        titleLabel.text = L10n.Signin.signIn
        emailTextField.placeholder = L10n.Signin.email
        passwordTextField.placeholder = L10n.Signin.password
        signInButton.setTitle(L10n.Signin.signIn.uppercased(), for: .normal)
    }
}

// MARK:- WSCall
extension SignInVC {
    private func signIn(email: String, pwd: String) {
        self.showNPLoader()
        try? wsClient.signIn(email: email, pwd: pwd) {
            self.hideNPLoader()
            self.delegate?.didSignedIn()
        }
    }
}
