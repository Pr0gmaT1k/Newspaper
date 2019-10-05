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
    func createPost(title: String, description: String?, body: String?)
    func back()
    func addImage()
}

// MARK:- Class
final class CreatePostVC: UIViewController {
    // MARK:- Properties
    weak var delegate: CreatePostVCDelegate?
    
    // MARK:- IBOutlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var titleTextField: UITextField!
    @IBOutlet private weak var descriptionTextField: UITextField!
    @IBOutlet private weak var bodyTextField: UITextField!
    @IBOutlet private weak var addPostButton: UIButton!
    @IBOutlet private weak var postImage: UIImageView!
    @IBOutlet private weak var addImageButton: UIButton!
    @IBOutlet private weak var addImageLabel: UILabel!
    
    // MARK:- IBActions
    @IBAction func addImageButtonDidTap(_ sender: Any) {
        guard let title = titleLabel.text else { return }
        delegate?.createPost(title: title, description: descriptionTextField.text, body: bodyTextField.text)
    }
    
    @IBAction func createPostDidTap(_ sender: Any) {
        delegate?.addImage()
    }
    
    @IBAction func backButtonDidTap(_ sender: Any) {
        delegate?.back()
    }
    
    // MARK:- Funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = L10n.Create.title
        titleTextField.placeholder = L10n.Create.addTitle
        descriptionTextField.placeholder = L10n.Create.addDescription
        bodyTextField.placeholder = L10n.Create.addBody
        addImageLabel.text = L10n.Create.addPhoto
        addPostButton.setTitle(L10n.Create.addPostButton, for: .normal)
    }
}
