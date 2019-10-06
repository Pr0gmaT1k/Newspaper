//
//  XCTest+Utils.swift
//  NewspaperTests
//
//  Created by azerty on 06/10/2019.
//  Copyright © 2019 azerty. All rights reserved.
//

import XCTest

func XCTAssertVisible(_ view: UIView) {
    XCTAssertFalse(view.isHidden)
}

func XCTAssertHidden(_ view: UIView) {
    XCTAssertTrue(view.isHidden)
}

func XCTAssertEnabled(_ control: UIControl) {
    XCTAssertTrue(control.isEnabled)
}

func XCTAssertDisabled(_ control: UIControl) {
    XCTAssertFalse(control.isEnabled)
}
