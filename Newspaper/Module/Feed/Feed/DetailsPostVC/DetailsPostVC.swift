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
    var post: Post?
    
    // MARK:- IBOutlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var imageHeader: UIImageView!
    @IBOutlet private weak var postTitleLabel: UILabel!
    @IBOutlet private weak var postDescriptionLabel: UILabel!
    @IBOutlet private weak var postBodyLabel: UILabel!
    
    // MARK:- IBActions
    @IBAction func backButtonDIdtap(_ sender: Any) {
        delegate?.back()
    }
    
    // MARK:- Funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = L10n.Details.title
        let randomNumber = Int.random(in: 1...23)
        imageHeader.image = UIImage(named: "\(randomNumber)")
        
        guard let post = post else { return }
        fill(post: post)
    }
    
    private func fill(post: Post) {
        postTitleLabel.text = post.title
        postDescriptionLabel.text = post.postDescription
        postBodyLabel.text = post.body
        
    }
}
