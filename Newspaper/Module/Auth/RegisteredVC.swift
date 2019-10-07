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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLabel.text = L10n.Registered.accountCreated
        self.startButton.setTitle(L10n.Registered.start, for: .normal)
    }
}
