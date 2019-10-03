//
//  Sequence+Utils.swift
//  Meteo
//
//  Created by azerty on 06/06/2018.
//  Copyright © 2018 Pr0g. All rights reserved.
//

import UIKit

extension Sequence {
    func group<U: Hashable>(by key: (Iterator.Element) -> U) -> [U: [Element]] {
        return Dictionary.init(grouping: self, by: key)
    }
}
