//
//  Reminder.swift
//  UTBus
//
//  Created by Dilip Ojha on 2015-06-26.
//  Copyright (c) 2015 madlab. All rights reserved.
//

import UIKit

class Reminder: NSObject {
    
    var notificationTime: NSDate
    
    var busTime: String
    var busLocation: String
    
    var UUID: String
    
    var repeat: Bool
    
    init(notificationTime: NSDate,busLocation: String,busTime: String, UUID: String, repeat: Bool){
        self.notificationTime = notificationTime
        self.busLocation = busLocation
        self.busTime = busTime
        self.UUID = UUID
        self.repeat = repeat
    }
    
    var isOverdue: Bool {
        return (NSDate().compare(self.notificationTime) == NSComparisonResult.OrderedDescending) // deadline is earlier than current date
    }

}
