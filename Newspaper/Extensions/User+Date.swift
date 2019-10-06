//
//  User+Date.swift
//  Newspaper
//
//  Created by azerty on 06/10/2019.
//  Copyright © 2019 azerty. All rights reserved.
//

import UIKit

extension User {
    var dateObject: Date? {
        guard let dateStr = self.created_at else { return nil }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return formatter.date(from: dateStr)
    }
    
    var formattedDate: String? {
        guard let date = self.dateObject else { return "" }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd LLLL yyyy HH:mm"
        let formatted = formatter.string(from: date)
        
        return formatted
        
    }
}
