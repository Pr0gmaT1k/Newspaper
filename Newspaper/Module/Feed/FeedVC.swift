//
//  FeedViewController.swift
//  Newspaper
//
//  Created by azerty on 04/10/2019.
//  Copyright © 2019 azerty. All rights reserved.
//

import UIKit

// MARK:- Delegate
protocol FeedVCDelegate: class {
    
}

// MARK:- Class
final class FeedVC: UIViewController {
    // MARK:- Properties
    weak var delegate: FeedVCDelegate?
    
    // MARK:- IBOutlets
    
    // MARK:- Funcs
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}