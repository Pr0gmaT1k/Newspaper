//
//  Realm.swift
//  Meteo
//
//  Created by azerty on 04/06/2018.
//  Copyright © 2018 Pr0g. All rights reserved.
//

import UIKit

import RealmSwift
import RxSwift

extension Realm {
    static func safeInstance() -> Realm {
        do {
            return try Realm()
        } catch {
            fatalError("\(error)")
        }
    }
}
