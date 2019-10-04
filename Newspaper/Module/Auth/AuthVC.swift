//
//  AuthVC.swift
//  Newspaper
//
//  Created by azerty on 03/10/2019.
//  Copyright © 2019 azerty. All rights reserved.
//

import UIKit

final class AuthVC: UIViewController {
    // MARK:- IBOutlets
    @IBOutlet private weak var copyrightLabel: UILabel!
    @IBOutlet private weak var signInButton: UIButton!
    @IBOutlet private weak var signUpButton: UIButton!
    
    // MARK:- IBActions
    @IBAction func signInDidTap(_ sender: Any) {
        self.navigationController?.pushViewController(StoryboardScene.Auth.signInVC.instantiate(), animated: true)
    }
    
    @IBAction func signUpDidTap(_ sender: Any) {
        self.navigationController?.pushViewController(StoryboardScene.Auth.signUpVC.instantiate(), animated: true)
    }
    
    // MARK:- Funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        self.copyrightLabel.text = L10n.copyright
        self.signInButton.setTitle(L10n.signIn.uppercased(), for: .normal)
        self.signUpButton.setTitle(L10n.signUp.uppercased(), for: .normal)
        
        // Could not be set in storyboard because borderColor take CGColor
        // and storyboard give a UIColor.
        self.signUpButton.layer.borderColor = ColorName.primary.color.cgColor
    }
}
