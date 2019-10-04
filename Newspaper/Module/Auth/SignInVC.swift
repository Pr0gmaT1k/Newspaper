//
//  SignInVC.swift
//  Newspaper
//
//  Created by azerty on 03/10/2019.
//  Copyright © 2019 azerty. All rights reserved.
//

import UIKit

protocol SignInVCDelegate: class {
    func signInButtonDidTap(email: String, pwd: String)
}

final class SignInVC: UIViewController {
    // MARK:- Properties
    weak var delegate: SignInVCDelegate?
    
    // MARK:- IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
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
        delegate?.signInButtonDidTap(email: email, pwd: pwd)
    }
    
    // MARK:- Funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = L10n.signIn
        emailTextField.placeholder = L10n.email
        passwordTextField.placeholder = L10n.password
        signInButton.setTitle(L10n.signIn.uppercased(), for: .normal)
    }
}
