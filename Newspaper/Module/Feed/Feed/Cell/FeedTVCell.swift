//
//  FeedTVCell.swift
//  Newspaper
//
//  Created by azerty on 05/10/2019.
//  Copyright © 2019 azerty. All rights reserved.
//

import UIKit
import Reusable

final class FeedTVCell: UITableViewCell, NibReusable {
    // MARK:- IBOutlets
    @IBOutlet private weak var imageCell: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    // MARK:- funcs
    func fill(post: Post?) {
        titleLabel.text = post?.title
        descriptionLabel.text = post?.postDescription
        let randomNumber = Int.random(in: 1...23)
        imageCell.image = UIImage(named: "\(randomNumber)")
    }
}
