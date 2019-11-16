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
    func didTapAddPost()
    func didSelect(post: Post?)
}

// MARK:- Class
final class FeedVC: UIViewController {
    // MARK:- Properties
    private let wsClient = NPWebServiceClient()
    weak var delegate: FeedVCDelegate?
    private static let cellRatio: CGFloat = 1920 / 1080 // (width / heigh)
    private var source: [Post?]?
    private var photoSource: [UIImage]?
    var shouldRefresh: Bool = true {
        didSet {
            self.updatePosts()
        }
    }
    
    // MARK:- IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var addPostButton: UIButton!
    
    // MARK:- IBActions
    @IBAction func addPostButtonDidTap(_ sender: Any) {
        delegate?.didTapAddPost()
    }
    
    // MARK:- Funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = self.tableView.frame.width / FeedVC.cellRatio
        self.tableView.register(cellType: FeedTVCell.self)
        self.addPostButton.setTitle(L10n.Feed.addPost.uppercased(), for: .normal)
        updatePosts()
    }
    
    private func refreshUI(posts: Posts?) {
        self.source = posts?.posts.reversed()
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didSelect(post: source?[indexPath.row])
    }
}

// MARK:- WS Call
extension FeedVC {
     private func updatePosts() {
        self.showNPLoader()
        NPWebServiceClient.getPosts { [weak self] result in
            self?.hideNPLoader()
            switch result {
            case let .success(posts): self?.refreshUI(posts: posts)
            case let .failure(error): self?.showToast(message: error, backgroundColor: Color(named: .scarlett))
            }
        }
    }
}
