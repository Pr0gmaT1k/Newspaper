//
//  CreatePostVC.swift
//  Newspaper
//
//  Created by azerty on 05/10/2019.
//  Copyright © 2019 azerty. All rights reserved.
//

import UIKit

// MARK:- Delegate
protocol CreatePostVCDelegate: class {
    func didTapBack()
    func didCreatePost()
}

// MARK:- Class
final class CreatePostVC: UIViewController {
    // MARK:- Properties
    weak var delegate: CreatePostVCDelegate?
    static let titleLengthLimit = 30
    static let bodylengthLimit = 1000
    static let descriptionLengthLimit = 100
    
    // MARK:- IBOutlets
    @IBOutlet private weak var titleFieldBackground: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var titleTextField: UITextField!
    @IBOutlet private weak var descriptionTextField: UITextField!
    @IBOutlet private weak var bodyTextField: UITextField!
    @IBOutlet private weak var addPostButton: UIButton!
    @IBOutlet private weak var postImage: UIImageView!
    @IBOutlet private weak var addImageButton: UIButton!
    @IBOutlet private weak var addImageLabel: UILabel!
    @IBOutlet private weak var descriptionCountLabel: UILabel!
    @IBOutlet private weak var bodyCountlabel: UILabel!
    @IBOutlet private weak var scrollView: UIScrollView!
    
    // MARK:- IBActions
    @IBAction func addImageButtonDidTap(_ sender: Any) {
        self.view.endEditing(true)
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.sourceType = .photoLibrary
            imagePickerController.delegate = self
            self.navigationController?.present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    @IBAction func createPostDidTap(_ sender: Any) {
        guard let title = titleTextField.text else { return }
        if title.isEmpty == false {
            createPost(title: title, description: descriptionTextField.text, body: bodyTextField.text)
        } else {
            self.scrollView.setContentOffset(.zero, animated: true)
            self.titleFieldBackground.backgroundColor = ColorName.scarlett.color.withAlphaComponent(30/100)
        }
    }
    
    @IBAction func backButtonDidTap(_ sender: Any) {
        delegate?.didTapBack()
    }
    
    // MARK:- Funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register keyboard notifications
        self.registerForKeyboardNotifications()
        
        // Setup label
        titleLabel.text = L10n.Create.title
        titleTextField.placeholder = L10n.Create.addTitle
        descriptionTextField.placeholder = L10n.Create.addDescription
        bodyTextField.placeholder = L10n.Create.addBody
        addImageLabel.text = L10n.Create.addPhoto
        addPostButton.setTitle(L10n.Create.addPostButton, for: .normal)
        descriptionCountLabel.text = L10n.Create.countDescription(0)
        bodyCountlabel.text = L10n.Create.countBody(0)
        
        // Delegate
        bodyTextField.delegate = self
        descriptionTextField.delegate = self
        titleTextField.delegate = self
    }
    
    deinit {
        self.deregisterFromKeyboardNotifications()
    }
}

extension CreatePostVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == descriptionTextField {
            guard let text = textField.text else { return true }
            let newLength = text.count + string.count - range.length
            if newLength > CreatePostVC.descriptionLengthLimit { return false }
            descriptionCountLabel.text = L10n.Create.countDescription(newLength)
        } else if textField == bodyTextField {
            guard let text = textField.text else { return true }
            let newLength = text.count + string.count - range.length
            if newLength > CreatePostVC.bodylengthLimit { return false }
            bodyCountlabel.text = L10n.Create.countBody(newLength)
        } else if textField == titleTextField {
            guard let text = textField.text else { return true }
            let newLength = text.count + string.count - range.length
            if newLength > CreatePostVC.titleLengthLimit { return false }
        }
        return true
    }
}

// MARK:- Keyboard scroll inset + scroll to active field
extension CreatePostVC {
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

// MARK:- UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension CreatePostVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    // TODO: to be moved in the coordinator
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        self.postImage.image = image
        picker.dismiss(animated: true, completion: nil)
    }
}

// MARK:- WS
extension CreatePostVC {
    func createPost(title: String, description: String?, body: String?) {
        self.showNPLoader()
        try? NPWebServiceClient.createPost(title: title, description: description, body: body) {
            self.hideNPLoader()
            self.delegate?.didCreatePost()
        }
    }
}
