//
//  SignUpVC.swift
//  Newspaper
//
//  Created by azerty on 03/10/2019.
//  Copyright © 2019 azerty. All rights reserved.
//

import UIKit

final class SignUpVC: UIViewController {
    // MARK:- IBOutlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var surnameTextField: UITextField!
    @IBOutlet private weak var rutTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var registerButton: UIButton!
    @IBOutlet private weak var emailTextField: UITextField!
    
    // MARK:- IBActions
    @IBAction func backButtonDidTouch(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func registerButtonDidTouch(_ sender: Any) {
        
    }
    
    @IBAction func showPwdDidTouch(_ sender: Any) {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
    }
    
    // MARK:- Funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = L10n.signUp
        nameTextField.placeholder = L10n.name
        surnameTextField.placeholder = L10n.surname
        rutTextField.placeholder = L10n.idNumber
        passwordTextField.placeholder = L10n.password
        emailTextField.placeholder = L10n.email
        registerButton.setTitle(L10n.signUp.uppercased(), for: .normal)
        
    }
}
