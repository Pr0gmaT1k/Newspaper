//
//  SignUpVC.swift
//  Newspaper
//
//  Created by azerty on 03/10/2019.
//  Copyright © 2019 azerty. All rights reserved.
//

import UIKit
import RxSwift

// MARK:- Delegate
protocol SignUpVCDelegate: class {
    func didSignedUpAndIsSignedIn()
    func didTapBack()
}

// MARK:- Class
final class SignUpVC: UIViewController {
    // MARK:- Properties
    weak var delegate: SignUpVCDelegate?
    private let bag = DisposeBag()
    private let wsClient = NPWebServiceClient()
    
    // MARK:- IBOutlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var surnameTextField: UITextField!
    @IBOutlet private weak var rutTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var registerButton: UIButton!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var scrollView: UIScrollView!
    
    // MARK:- IBActions
    @IBAction func backButtonDidTouch(_ sender: Any) {
        delegate?.didTapBack()
    }
    
    @IBAction func registerButtonDidTouch(_ sender: Any) {
        guard let name = nameTextField.text,
            let lastname = surnameTextField.text,
            let email = emailTextField.text,
            let dni = rutTextField.text,
            let pwd = passwordTextField.text else { return }
        // WARNING: The API require pwd confirmation but there is no textfield in relation on the zeplin design.
        // I choose to be conform to the design.
        signUp(name: name, lastName: lastname, dni: dni, email: email, pwd: pwd, pwdConfirmation: pwd)
    }
    
    @IBAction func showPwdDidTouch(_ sender: Any) {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
    }
    
    // MARK:- Funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register keyboard notifications
        self.registerForKeyboardNotifications()
        
        // Setup label
        titleLabel.text = L10n.Signup.signUp
        nameTextField.placeholder = L10n.Signup.name
        surnameTextField.placeholder = L10n.Signup.surname
        rutTextField.placeholder = L10n.Signup.idNumber
        passwordTextField.placeholder = L10n.Signup.password
        emailTextField.placeholder = L10n.Signup.email
        registerButton.setTitle(L10n.Signup.signUp.uppercased(), for: .normal)
    }
    
    deinit {
        self.deregisterFromKeyboardNotifications()
    }
}

// MARK:- Keyboard scroll inset + scroll to active field
extension SignUpVC {
    private func registerForKeyboardNotifications() {
        //Adding notifies on keyboard appearing
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func deregisterFromKeyboardNotifications() {
        //Removing notifies on keyboard appearing
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWasShown(notification: NSNotification) {
        //Need to calculate keyboard exact size due to Apple suggestions
        let info = notification.userInfo
        guard let keyboardSize = (info?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size else { return }
        let contentInsets: UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)

        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
    }

    @objc func keyboardWillBeHidden(notification: NSNotification) {
        //Once keyboard disappears, restore original positions
        let info = notification.userInfo
        guard let keyboardSize = (info?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size else { return }
        let contentInsets: UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: -keyboardSize.height, right: 0.0)
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        self.view.endEditing(true)
        self.scrollView.isScrollEnabled = false
    }
}

// MARK:- WS Call
extension SignUpVC {
    private func signUp(name: String, lastName: String, dni: String, email: String, pwd: String, pwdConfirmation: String) {
        self.showNPLoader()
        try? wsClient.register(name: name, lastname: lastName, dni: dni, email: email, pwd: pwd, pwdConfimation: pwdConfirmation) {
            self.signIn(email: email, pwd: pwd)
        }
    }
    
    private func signIn(email: String, pwd: String) {
        self.showNPLoader()
        try? wsClient.signIn(email: email, pwd: pwd) {
            self.hideNPLoader()
            self.delegate?.didSignedUpAndIsSignedIn()
        }
    }
}
