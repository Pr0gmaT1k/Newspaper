//
//  DetailsVCTests.swift
//  NewspaperTests
//
//  Created by azerty on 06/10/2019.
//  Copyright © 2019 azerty. All rights reserved.
//

import XCTest
@testable import Newspaper

final class DetailsVCTests: XCTestCase {
    // MARK: - Properties
    private var viewController: DetailsPostVC!
    private var topLevelUIUtilities = TopLevelUIViewController<DetailsPostVC>()
    private var calldidBack: XCTestExpectation?
    
    // MARK:- Tests
    override func setUp() {
        super.setUp()
        viewController = StoryboardScene.Feed.detailsPostVC.instantiate()
        viewController.delegate = self
        topLevelUIUtilities.setupTopLevelUI(with: viewController, inNavigationController: false)
    }
    
    override func tearDown() {
        super.tearDown()
        topLevelUIUtilities.tearDownTopLevelUI()
    }
    
    func testDidBack() {
        calldidBack = expectation(description: "will call didTapBack delegate")
        viewController.backButtonDIdtap(self)
        wait(for: calldidBack!)
    }
}

// MARK:- DetailsPostVCDelegate
extension DetailsVCTests: DetailsPostVCDelegate {
    func didTapBack() {
        calldidBack?.fulfill()
    }
}
