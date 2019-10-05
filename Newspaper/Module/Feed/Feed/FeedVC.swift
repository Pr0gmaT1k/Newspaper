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
    private static let cellRatio: CGFloat = 364 / 220 // (Height / Width)
    
    // MARK:- IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK:- Funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = self.tableView.frame.width / FeedVC.cellRatio
        self.tableView.register(cellType: FeedTVCell.self)
    }
}

// MARK:- UITableView Delegate / Data Source
extension FeedVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(for: indexPath) as FeedTVCell
        cell.fill(post: nil)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = FeedTVHeader()
        view.fill(title: L10n.Feed.Header.title)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 95
    }
}
