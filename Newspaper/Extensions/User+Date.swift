//
//  User+Date.swift
//  Newspaper
//
//  Created by azerty on 06/10/2019.
//  Copyright © 2019 azerty. All rights reserved.
//

import UIKit

extension User {
    /// The Date object of self.createdDate
    var createdDateObject: Date? {
        guard let dateStr = self.created_at else { return nil }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return formatter.date(from: dateStr)
    }
    
    /// The human readable string of self.createdDate
    var createdFormattedDate: String? {
        guard let date = self.createdDateObject else { return "" }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd LLLL yyyy HH:mm"
        let formatted = formatter.string(from: date)
        
        return formatted
        
    }
}
