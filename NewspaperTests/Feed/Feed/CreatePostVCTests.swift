//
//  CreatePostVCTests.swift
//  NewspaperTests
//
//  Created by azerty on 06/10/2019.
//  Copyright © 2019 azerty. All rights reserved.
//

import XCTest
@testable import Newspaper

final class CreatePostVCTests: XCTestCase {
    // MARK: - Properties
    private var viewController: CreatePostVC!
    private var topLevelUIUtilities = TopLevelUIViewController<CreatePostVC>()
    private var calldidBack: XCTestExpectation?
    
    // MARK:- Tests
    override func setUp() {
        super.setUp()
        viewController = StoryboardScene.Feed.createPostVC.instantiate()
        viewController.delegate = self
        topLevelUIUtilities.setupTopLevelUI(with: viewController, inNavigationController: false)
    }
    
    override func tearDown() {
        super.tearDown()
        topLevelUIUtilities.tearDownTopLevelUI()
    }
    
    func testDidBack() {
        calldidBack = expectation(description: "will call didTapBack delegate")
        viewController.backButtonDidTap(self)
        wait(for: calldidBack!)
    }
}

// MARK:- CreatePostVCDelegate
extension CreatePostVCTests: CreatePostVCDelegate {
    func didTapBack() {
        calldidBack?.fulfill()
    }
    
    func didCreatePost() {}
}
