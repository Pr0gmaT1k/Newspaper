//
//  TestExpectationWrapper.swift
//  NewspaperTests
//
//  Created by azerty on 06/10/2019.
//  Copyright © 2019 azerty. All rights reserved.
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
