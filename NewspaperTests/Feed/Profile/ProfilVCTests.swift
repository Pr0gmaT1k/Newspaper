//
//  ProfilVCTests.swift
//  NewspaperTests
//
//  Created by azerty on 06/10/2019.
//  Copyright © 2019 azerty. All rights reserved.
//

import XCTest
@testable import Newspaper

final class ProfilVCTests: XCTestCase {
    // MARK: - Properties
    private var viewController: ProfileVC!
    private var topLevelUIUtilities = TopLevelUIViewController<ProfileVC>()
    private var callDidCloseSession: XCTestExpectation?
    
    // MARK:- Tests
    override func setUp() {
        super.setUp()
        viewController = StoryboardScene.Feed.profileVC.instantiate()
        viewController.delegate = self
        topLevelUIUtilities.setupTopLevelUI(with: viewController, inNavigationController: false)
    }
    
    override func tearDown() {
        super.tearDown()
        topLevelUIUtilities.tearDownTopLevelUI()
    }
    
    func testCloseSession() {
        callDidCloseSession = expectation(description: "will call didTapAddPost delegate")
        viewController.closeSessionButtonDidTouch(self)
        wait(for: callDidCloseSession!)
    }
}

// MARK:- ProfileVC delegate
extension ProfilVCTests: ProfileVCDelegate {
    func didClosedSession() {
        callDidCloseSession?.fulfill()
    }
}
