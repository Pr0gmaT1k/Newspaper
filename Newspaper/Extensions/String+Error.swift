//
//  String+Error.swift
//  Newspaper
//
//  Created by azerty on 16/11/2019.
//  Copyright © 2019 azerty. All rights reserved.
//

import Foundation

extension String: LocalizedError {
    public var errorDescription: String? { return self }
}
