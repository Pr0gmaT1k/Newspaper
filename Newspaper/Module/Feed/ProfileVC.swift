//
//  ProfileVC.swift
//  Newspaper
//
//  Created by azerty on 05/10/2019.
//  Copyright © 2019 azerty. All rights reserved.
//

import UIKit

// MARK:- Delegate
protocol ProfileVCDelegate: class {
    
}

// MARK:- Class
final class ProfileVC: UIViewController {
    // MARK:- Properties
    weak var delegate: ProfileVCDelegate?
    
    // MARK:- IBOutlets
    
    // MARK:- Funcs
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
