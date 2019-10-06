//
//  FriendVC.swift
//  Newspaper
//
//  Created by azerty on 05/10/2019.
//  Copyright © 2019 azerty. All rights reserved.
//

import UIKit

// MARK:- Delegate
protocol FriendVCDelegate: class {
    
}

// MARK:- Class
final class FriendVC: UIViewController {
    // MARK:- Properties
    weak var delegate: FriendVCDelegate?
    
    // MARK:- IBOutlets
    
    // MARK:- Funcs
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
