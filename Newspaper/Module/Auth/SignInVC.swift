//
//  SignInVC.swift
//  Newspaper
//
//  Created by azerty on 03/10/2019.
//  Copyright © 2019 azerty. All rights reserved.
//

import UIKit

// MARK:- Delegate
protocol SignInVCDelegate: class {
    func signInButtonDidTap(email: String, pwd: String, vc: SignInVC)
}

// MARK:- Class
final class SignInVC: UIViewController {
    // MARK:- Properties
    weak var delegate: SignInVCDelegate?
    
    // MARK:- IBOutlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var signInButton: UIButton!
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var errorView: UIView!
    
    // MARK:- IBActions
    @IBAction func showPwdDidTouch(_ sender: Any) {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
    }
    
    @IBAction func backButtonDidTouch(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func signInButtonDidTouch(_ sender: Any) {
        // Should be move in a coordinator
        guard let email = emailTextField.text, let pwd = passwordTextField.text else { return }
        delegate?.signInButtonDidTap(email: email, pwd: pwd, vc: self)
    }
    
    // MARK:- Funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        // error
        errorView.alpha = 0
        
        // Label
        titleLabel.text = L10n.signIn
        emailTextField.placeholder = L10n.email
        passwordTextField.placeholder = L10n.password
        signInButton.setTitle(L10n.signIn.uppercased(), for: .normal)
    }
    
    func displayError(error: String) {
        errorLabel.text = error
        UIView.animate(withDuration: 2.0, animations: {
            self.errorView.alpha = 1.0
        }) { (finished) in
            UIView.animate(withDuration: 2.0, animations: {
                self.errorView.alpha = 0.0
            })
        }
    }
}
