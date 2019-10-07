//
//  SignUpVCTests.swift
//  NewspaperTests
//
//  Created by azerty on 06/10/2019.
//  Copyright © 2019 azerty. All rights reserved.
//

import XCTest
@testable import Newspaper

final class SignUpVCTests: XCTestCase {
    // MARK: - Properties
    private var viewController: SignUpVC!
    private var topLevelUIUtilities = TopLevelUIViewController<SignUpVC>()
    private var calldidBack: XCTestExpectation?
    
    // MARK:- Tests
    override func setUp() {
        super.setUp()
        viewController = StoryboardScene.Auth.signUpVC.instantiate()
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

// MARK:- SignUp VC Delegate
extension SignUpVCTests: SignUpVCDelegate {
    func didSignedUpAndIsSignedIn() {}
    
    func didTapBack() {
        calldidBack?.fulfill()
    }
}
