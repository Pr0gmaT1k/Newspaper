//
//  FulfillableViewController.swift
//  NewspaperTests
//
//  Created by azerty on 06/10/2019.
//  Copyright © 2019 azerty. All rights reserved.
//

import Foundation
import XCTest

final class FulfillableViewController: UIViewController {

    // MARK: - Properties

    var fulfillOnViewDidLoad = false {
        didSet {
            callViewDidLoadExpectation = fulfillOnViewDidLoad ? XCTestExpectation(description: "viewDidLoad expectation") : nil
        }
    }
    var fulfillOnViewDidAppear = false {
        didSet {
            callViewDidAppearExpectation = fulfillOnViewDidAppear ? XCTestExpectation(description: "viewDidAppear expectation") : nil

        }
    }
    var fulfillOnViewDidDisappear = false {
        didSet {
            callViewDidDisappearExpectation = fulfillOnViewDidDisappear ? XCTestExpectation(description: "viewDidDisappear expectation") : nil
        }
    }

    var pendingExpectations: [XCTestExpectation] {
        return [callViewDidLoadExpectation, callViewDidAppearExpectation, callViewDidDisappearExpectation].compactMap({ $0 })
    }

    private var callViewDidLoadExpectation: XCTestExpectation?
    private var callViewDidAppearExpectation: XCTestExpectation?
    private var callViewDidDisappearExpectation: XCTestExpectation?

    // MARK: - Funcs

    override func viewDidLoad() {
        super.viewDidLoad()

        if fulfillOnViewDidLoad {
            callViewDidLoadExpectation!.fulfill()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if fulfillOnViewDidAppear {
            callViewDidAppearExpectation!.fulfill()
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        if fulfillOnViewDidDisappear {
            callViewDidDisappearExpectation!.fulfill()
        }
    }
}
