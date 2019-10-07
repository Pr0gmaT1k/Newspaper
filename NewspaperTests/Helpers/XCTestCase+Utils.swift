//
//  Configuration.swift
//  NewspaperTests
//
//  Created by azerty on 06/10/2019.
//  Copyright © 2019 azerty. All rights reserved.
//

import XCTest

extension XCTestCase {

    // MARK: - Constants

    public enum Constants {
        static let defaultTimeout = Duration(100, .millisecond)
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
