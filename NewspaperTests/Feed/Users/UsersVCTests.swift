//
//  UsersVCTests.swift
//  NewspaperTests
//
//  Created by azerty on 06/10/2019.
//  Copyright © 2019 azerty. All rights reserved.
//

import XCTest
@testable import Newspaper

final class UsersVCTests: XCTestCase {
    // MARK: - Properties
    private var viewController: UsersVC!
    private var topLevelUIUtilities = TopLevelUIViewController<UsersVC>()
    
    // MARK:- Tests
    override func setUp() {
        super.setUp()
        viewController = StoryboardScene.Feed.usersVC.instantiate()
        viewController.delegate = self
        topLevelUIUtilities.setupTopLevelUI(with: viewController, inNavigationController: false)
    }
    
    override func tearDown() {
        super.tearDown()
        topLevelUIUtilities.tearDownTopLevelUI()
    }
}

// MARK:- UsersVC Delegate
extension UsersVCTests: UsersVCDelegate {
    
}
