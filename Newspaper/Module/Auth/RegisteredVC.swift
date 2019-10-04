//
//  RegisteredVC.swift
//  Newspaper
//
//  Created by azerty on 04/10/2019.
//  Copyright © 2019 azerty. All rights reserved.
//

import UIKit

protocol RegisteredVCDelegate: class {
    func startButtonTapped()
    func backButtonDidTapped()
}

final class RegisteredVC: UIViewController {
    // MARK:- Properties
    weak var delegate: RegisteredVCDelegate?
    
    // MARK:- IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    // MARK:- IBActions
    @IBAction func startButtonDidTap(_ sender: Any) {
        delegate?.startButtonTapped()
    }
    
    @IBAction func backButtonDidTap(_ sender: Any) {
        delegate?.backButtonDidTapped()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
