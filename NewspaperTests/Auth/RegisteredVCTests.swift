//
//  RegisteredVCTests.swift
//  NewspaperTests
//
//  Created by azerty on 06/10/2019.
//  Copyright © 2019 azerty. All rights reserved.
//

import XCTest
@testable import Newspaper

final class RegisteredVCTests: XCTestCase {
    // MARK: - Properties
    private var viewController: RegisteredVC!
    private var topLevelUIUtilities = TopLevelUIViewController<RegisteredVC>()
    private var callDidStart: XCTestExpectation?
    
    // MARK:- Tests
    override func setUp() {
        super.setUp()
        viewController = StoryboardScene.Auth.registeredVC.instantiate()
        viewController.delegate = self
        topLevelUIUtilities.setupTopLevelUI(with: viewController, inNavigationController: false)
    }
    
    override func tearDown() {
        super.tearDown()
        topLevelUIUtilities.tearDownTopLevelUI()
    }
    
    func testDidStart() {
        callDidStart = expectation(description: "will call didTapSignIn delegate")
        viewController.startButtonDidTap(self)
        wait(for: callDidStart!)
    }
}

// MARK:- RegisteredVC Delegate
extension RegisteredVCTests: RegisteredVCDelegate {
    func didTapStartButton() {
        callDidStart?.fulfill()
    }
}
