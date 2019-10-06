//
//  TestExpectationWrapper.swift
//  ApolloTests
//
//  Created by JBR on 11/03/2019.
//  Copyright © 2019 URGO. All rights reserved.
//

import XCTest

final class EquatableExpectation<T: Equatable>: XCTestExpectation {

    // MARK: - Properties

    private let expectedValue: T

    // MARK: - Init

    init(description: String = "", expectedValue: T) {
        self.expectedValue = expectedValue

        super.init(description: description)
    }

    // MARK: - Funcs

    func fulfillIfEqual(to value: T) {
        guard value == expectedValue else {
            XCTFail("Expected value was \(expectedValue) but given value was \(value).")
            return
        }

        fulfill()
    }
}
