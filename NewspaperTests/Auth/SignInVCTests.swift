//
//  SignInVCTests.swift
//  NewspaperTests
//
//  Created by azerty on 06/10/2019.
//  Copyright © 2019 azerty. All rights reserved.
//

import XCTest
@testable import Newspaper

final class SignInVCTests: XCTestCase {
    // MARK: - Properties
    private var viewController: SignInVC!
    private var topLevelUIUtilities = TopLevelUIViewController<SignInVC>()
    private var calldidBack: XCTestExpectation?
    
    // MARK:- Tests
    override func setUp() {
        super.setUp()
        viewController = StoryboardScene.Auth.signInVC.instantiate()
        viewController.delegate = self
        topLevelUIUtilities.setupTopLevelUI(with: viewController, inNavigationController: false)
    }
    
    override func tearDown() {
        super.tearDown()
        topLevelUIUtilities.tearDownTopLevelUI()
    }
    
    func testDidBack() {
        calldidBack = expectation(description: "will call didTapBack delegate")
        viewController.backButtonDidTouch(self)
        wait(for: calldidBack!)
    }
}

extension SignInVCTests: SignInVCDelegate {
    func didTapBack() {
        calldidBack?.fulfill()
    }
    
    func didSignedIn() {}
}
