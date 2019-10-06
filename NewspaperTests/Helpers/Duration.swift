//
//  Duration.swift
//  NewspaperTests
//
//  Created by azerty on 06/10/2019.
//  Copyright © 2019 azerty. All rights reserved.
//

import Foundation

public struct Duration {

    public enum Unit: Double {

        case millisecond = 1
        case decisecond = 10
        case centisecond = 100
        case second = 1_000
        case minute = 60_000
        case hour = 3_600_000
        case day = 86_400_000
        case week = 604_800_000
    }

    // MARK: Properties

    private let value: Double
    private let unit: Unit

    // MARK: Init

    public init(_ value: Double, _ unit: Unit) {
        self.value = value
        self.unit = unit
    }

    // MARK: Funcs

   public func `in`(_ unit: Unit) -> Double {
        return value * self.unit.rawValue * (1 / unit.rawValue)
    }
}
