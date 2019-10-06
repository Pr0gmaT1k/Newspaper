//
//  AuthCoordinatorTests.swift
//  NewspaperTests
//
//  Created by azerty on 06/10/2019.
//  Copyright © 2019 azerty. All rights reserved.
//

import XCTest
@testable import Newspaper

final class AuthCoordinatorTests: XCTestCase {
    // MARK: - Properties
    private var coordinator: AuthCoordinator!
    private var callDidEndAuthFromSignIn: XCTestExpectation?
    private var callDidEndAuthFromRegister: XCTestExpectation?

    // MARK:- Tests
    override func setUp() {
        super.setUp()
        coordinator = AuthCoordinator()
        coordinator.delegate = self
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testAuthDidFinishFromSignIn() {
        callDidEndAuthFromSignIn = expectation(description: "will call authCoordinatorDidFinish delegate")
        coordinator.didSignedIn()
        wait(for: callDidEndAuthFromSignIn!)
    }
    
    func testAuthDidFinishFromSignUp() {
        callDidEndAuthFromRegister = expectation(description: "will call authCoordinatorDidFinish delegate")
        coordinator.didTapStartButton()
        wait(for: callDidEndAuthFromRegister!)
    }
}

// MARK:- AuthCoordinatorDelegate
extension AuthCoordinatorTests: AuthCoordinatorDelegate {
    func authCoordinatorDidFinish(_ coordinator: AuthCoordinator) {
        callDidEndAuthFromSignIn?.fulfill()
        callDidEndAuthFromRegister?.fulfill()
    }
}
