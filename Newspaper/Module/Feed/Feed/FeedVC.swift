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
    func requestposts(vc: FeedVC)
    func addpost()
}

// MARK:- Class
final class FeedVC: UIViewController {
    // MARK:- Properties
    weak var delegate: FeedVCDelegate?
    private static let cellRatio: CGFloat = 1920 / 1080 // (with / heigh)
    private var source: [Post?]?
    private var photoSource: [UIImage]?
    
    // MARK:- IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var addPostButton: UIButton!
    
    // MARK:- IBActions
    @IBAction func addPostButtonDidTap(_ sender: Any) {
        delegate?.addpost()
    }
    
    
    // MARK:- Funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = self.tableView.frame.width / FeedVC.cellRatio
        self.tableView.register(cellType: FeedTVCell.self)
        self.addPostButton.setTitle(L10n.Feed.addPost.uppercased(), for: .normal)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        delegate?.requestposts(vc: self)
    }
    
    func updatePosts(posts: Posts?) {
        self.source = posts?.posts.map { $0 }
        self.tableView.reloadData()
    }
}

// MARK:- UITableView Delegate / Data Source
extension FeedVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return source?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(for: indexPath) as FeedTVCell
        cell.fill(post: source?[indexPath.row])
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
