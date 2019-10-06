//
//  DetailsPostVC.swift
//  Newspaper
//
//  Created by azerty on 05/10/2019.
//  Copyright © 2019 azerty. All rights reserved.
//

import UIKit

// MARK:- Delegate
protocol DetailsPostVCDelegate: class {
    func back()
}

// MARK:- Class
final class DetailsPostVC: UIViewController {
    // MARK:- Properties
    weak var delegate: DetailsPostVCDelegate?
    
    // MARK:- IBOutlets
    
    // MARK:- IBActions
    
    // MARK:- Funcs
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func fill(post: Post) {
        
    }
}
