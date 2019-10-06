//
//  AuthVCTests.swift
//  NewspaperTests
//
//  Created by azerty on 06/10/2019.
//  Copyright © 2019 azerty. All rights reserved.
//

import XCTest
@testable import Newspaper

final class AuthVCTests: XCTestCase {
    // MARK: - Properties
    private var viewController: AuthVC!
    private var topLevelUIUtilities = TopLevelUIViewController<AuthVC>()
    private var callDidTapSignIn: XCTestExpectation?
    private var callDidTapSignUp: XCTestExpectation?
    
    // MARK:- Tests
    override func setUp() {
        super.setUp()
        viewController = StoryboardScene.Auth.authVC.instantiate()
        viewController.delegate = self
        topLevelUIUtilities.setupTopLevelUI(with: viewController, inNavigationController: false)
    }
    
    override func tearDown() {
        super.tearDown()
        topLevelUIUtilities.tearDownTopLevelUI()
    }
    
    func testTapSignIn() {
        callDidTapSignIn = expectation(description: "will call didTapSignIn delegate")
        viewController.signInDidTap(self)
        wait(for: callDidTapSignIn!)
    }
    
    func testTapSignUn() {
        callDidTapSignUp = expectation(description: "will call didTapSignUp delegate")
        viewController.signUpDidTap(self)
        wait(for: callDidTapSignUp!)
    }
}

// MARK:- AuthVC Delegate
extension AuthVCTests: AuthVCDelegate {
    func didTapSignUp() {
        callDidTapSignUp?.fulfill()
    }
    
    func didTapSignIn() {
        callDidTapSignIn?.fulfill()
    }
}
