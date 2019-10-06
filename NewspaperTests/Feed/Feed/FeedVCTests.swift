//
//  FeedVCTests.swift
//  NewspaperTests
//
//  Created by azerty on 06/10/2019.
//  Copyright © 2019 azerty. All rights reserved.
//

import XCTest
@testable import Newspaper

final class FeedVCTests: XCTestCase {
    // MARK: - Properties
    private var viewController: FeedVC!
    private var topLevelUIUtilities = TopLevelUIViewController<FeedVC>()
    private var callDidTapAddPost: XCTestExpectation?
    private var callDidSelectPost: XCTestExpectation?
    
    // MARK:- Tests
    override func setUp() {
        super.setUp()
        viewController = StoryboardScene.Feed.feedVC.instantiate()
        viewController.delegate = self
        topLevelUIUtilities.setupTopLevelUI(with: viewController, inNavigationController: false)
    }
    
    override func tearDown() {
        super.tearDown()
        topLevelUIUtilities.tearDownTopLevelUI()
    }
    
    func testAddPost() {
        callDidTapAddPost = expectation(description: "will call didTapAddPost delegate")
        viewController.addPostButtonDidTap(self)
        wait(for: callDidTapAddPost!)
    }
    
    func testSelectPost() {
        callDidSelectPost = expectation(description: "will call didSelect delegate")
        viewController.tableView(UITableView(), didSelectRowAt: IndexPath(item: 1, section: 0))
        wait(for: callDidSelectPost!)
    }
}

// MARK:- FeedVC Delegate
extension FeedVCTests: FeedVCDelegate {
    func didTapAddPost() {
        callDidTapAddPost?.fulfill()
    }
    
    func didSelect(post: Post?) {
        callDidSelectPost?.fulfill()
    }
}
