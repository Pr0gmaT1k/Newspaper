//
//  FeedTVHeader.swift
//  Newspaper
//
//  Created by azerty on 05/10/2019.
//  Copyright © 2019 azerty. All rights reserved.
//

import UIKit
import Reusable

final class FeedTVHeader: UIView, NibOwnerLoadable {
    // MARK:- IBOutlets
    @IBOutlet private weak var titleLabel: UILabel!
    
    // MARK:- funcs
    func fill(title: String) {
        self.loadNibContent()
        titleLabel.text = title
    }
}
