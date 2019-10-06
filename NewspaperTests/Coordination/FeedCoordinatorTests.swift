//
//  FeedCoordinatorTests.swift
//  NewspaperTests
//
//  Created by azerty on 06/10/2019.
//  Copyright © 2019 azerty. All rights reserved.
//

import XCTest
@testable import Newspaper

final class FeedCoordinatorTests: XCTestCase {
    // MARK: - Properties
    private var coordinator: FeedCoordinator!
    private var callDidEndFromCloseSession: XCTestExpectation?

    // MARK:- Tests
    override func setUp() {
        super.setUp()
        coordinator = FeedCoordinator()
        coordinator.delegate = self
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testAuthDidFinishFromSignIn() {
        callDidEndFromCloseSession = expectation(description: "will call feedCoordinatorDidFinish delegate")
        coordinator.didClosedSession()
        wait(for: callDidEndFromCloseSession!)
    }
}

// MARK:- AuthCoordinatorDelegate
extension FeedCoordinatorTests: FeedCoordinatorDelegate {
    func feedCoordinatorDidFinish(_ coordinator: FeedCoordinator, closeSession: Bool) {
        callDidEndFromCloseSession?.fulfill()
    }
}
