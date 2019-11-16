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
    func didClosedSession()
}

// MARK:- Class
final class ProfileVC: UIViewController {
    // MARK:- Properties
    weak var delegate: ProfileVCDelegate?
    
    // MARK:- IBOutlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var namesTitleLabel: UILabel!
    @IBOutlet private weak var profileNamesLabel: UILabel!
    @IBOutlet private weak var emailTitleLabel: UILabel!
    @IBOutlet private weak var profileEmailLabel: UILabel!
    @IBOutlet private weak var dniTitleLabel: UILabel!
    @IBOutlet private weak var profileDdniLabel: UILabel!
    @IBOutlet private weak var closeSessionButton: UIButton!
    
    // MARK:- IBActions
    @IBAction func closeSessionButtonDidTouch(_ sender: Any) {
        NPWebServiceClient.disconnect()
        delegate?.didClosedSession()
    }
    
    // MARK:- Funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = L10n.Profile.profile
        namesTitleLabel.text = L10n.Profile.names.uppercased()
        emailTitleLabel.text = L10n.Profile.email.uppercased()
        dniTitleLabel.text = L10n.Profile.dni.uppercased()
        closeSessionButton.setTitle(L10n.Profile.closeSession.uppercased(), for: .normal)
        // Could not be set in storyboard because borderColor take CGColor
        // and storyboard give a UIColor.
        closeSessionButton.layer.borderColor = ColorName.primary.color.cgColor
        // WS call
        requestUser()
    }
    
    private func fill(user: User?) {
        self.profileNamesLabel.text = (user?.name ?? "") + " " + (user?.lastname ?? "")
        self.profileEmailLabel.text = user?.email
        self.profileDdniLabel.text = user?.dni
    }
}

// MARK:- WS call
extension ProfileVC {
    private func requestUser() {
        self.showNPLoader()
        NPWebServiceClient.getCurrentUser { [weak self] result in
            self?.hideNPLoader()
            switch result {
            case let .success(user): self?.fill(user: user)
            case let .failure(error): self?.showToast(message: error, backgroundColor: Color(named: .scarlett))
            }
        }
    }
}
