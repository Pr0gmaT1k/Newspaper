//
//  Configuration.swift
//  ApolloTests
//
//  Created by JBR on 08/03/2019.
//  Copyright © 2019 URGO. All rights reserved.
//

import XCTest
import OpenKit

extension XCTestCase {

    // MARK: - Constants

    public enum Constants {
        static let defaultTimeout = Duration(50, .millisecond)
    }

    // MARK: - Funcs

    func waitForExpectations(handler: XCWaitCompletionHandler? = nil) {
        waitForExpectations(timeout: Constants.defaultTimeout.in(.second), handler: handler)
    }

    func wait(for expectation: XCTestExpectation, timeout: TimeInterval = Constants.defaultTimeout.in(.second)) {
        wait(for: [expectation], timeout: timeout)
    }

    func wait(for expectations: [XCTestExpectation]) {
        wait(for: expectations, timeout: Constants.defaultTimeout.in(.second))
    }

    func wait(for expectations: [XCTestExpectation], enforceOrder enforceOrderOfFulfillment: Bool) {
        wait(for: expectations, timeout: Constants.defaultTimeout.in(.second), enforceOrder: enforceOrderOfFulfillment)
    }
}
