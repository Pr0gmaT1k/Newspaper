//
//  UserTVCell.swift
//  Newspaper
//
//  Created by azerty on 06/10/2019.
//  Copyright © 2019 azerty. All rights reserved.
//

import UIKit
import Reusable

final class UserTVCell: UITableViewCell, NibReusable {
    // MARK:- IBOutlets
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var nombreLabel: UILabel!
    @IBOutlet private weak var nombreTitleLabel: UILabel!
    @IBOutlet private weak var emailTitleLabel: UILabel!
    @IBOutlet private weak var memberLabel: UILabel!
    @IBOutlet private weak var backView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nombreTitleLabel.text = L10n.Users.Cell.names
        emailTitleLabel.text = L10n.Users.Cell.email
    }
    
    // MARK:- Funcs
    func fill(user: User?, color: UIColor) {
        emailLabel.text = user?.email
        nombreLabel.text = (user?.name ?? "") + " " + (user?.lastname ?? "")
        memberLabel.text = L10n.Users.Cell.memberSince(user?.formattedDate ?? "")
        backView.backgroundColor = color
    }
}
