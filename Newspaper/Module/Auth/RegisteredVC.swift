//
//  RegisteredVC.swift
//  Newspaper
//
//  Created by azerty on 04/10/2019.
//  Copyright © 2019 azerty. All rights reserved.
//

import UIKit

// MARK:- Delegate
protocol RegisteredVCDelegate: class {
    func didTapStartButton()
    func didTapBack()
}

// MARK:- Class
final class RegisteredVC: UIViewController {
    // MARK:- Properties
    weak var delegate: RegisteredVCDelegate?
    
    // MARK:- IBOutlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var startButton: UIButton!
    
    // MARK:- IBActions
    @IBAction func startButtonDidTap(_ sender: Any) {
        delegate?.didTapStartButton()
    }
    
    @IBAction func backButtonDidTap(_ sender: Any) {
        delegate?.didTapBack()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLabel.text = L10n.cratedAccount
        self.startButton.setTitle(L10n.start, for: .normal)
    }
}
