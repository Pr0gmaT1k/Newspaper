//
//  FriendVC.swift
//  Newspaper
//
//  Created by azerty on 05/10/2019.
//  Copyright © 2019 azerty. All rights reserved.
//

import UIKit

// MARK:- Delegate
protocol UsersVCDelegate: class {
    func requestUser(vc: UsersVC)
}

// MARK:- Class
final class UsersVC: UIViewController {
    // MARK:- Properties
    weak var delegate: UsersVCDelegate?
    private var source: [User]?
    private let colorSource: [Color] = [ColorName.primary.color,
                                        ColorName.secondary.color,
                                        ColorName.scarlett.color]
    
    // MARK:- IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK:- Funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.register(cellType: UserTVCell.self)
        delegate?.requestUser(vc: self)
    }
    
    func updateUser(users: Users?) {
        self.source = users?.users.reversed()
        self.tableView.reloadData()
    }
    
    /// Circular array applied to self.colorSource.
    private func getColors(index: Int) -> Color {
        if self.colorSource.isEmpty { return ColorName.primary.color }
        let mod = index % self.colorSource.count
        let offset = index >= 0 ? 0 : self.colorSource.count
        let idx = mod == 0 ? 0 : mod + offset
        return self.colorSource[idx]
    }
}

// MARK:- UITableView DataSource
extension UsersVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(for: indexPath) as UserTVCell
        cell.fill(user: source?[indexPath.row], color: getColors(index: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return source?.count ?? 0
    }
}
