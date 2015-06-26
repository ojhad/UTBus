//
//  File.swift
//  UTBus
//
//  Created by Dilip Ojha on 2015-06-26.
//  Copyright (c) 2015 madlab. All rights reserved.
//

import Foundation
import UIKit

class ReminderList {
    class var sharedInstance : ReminderList {
        struct Static {
            static let instance : ReminderList = ReminderList()
        }
        return Static.instance
    }
    
    private let ITEMS_KEY = "reminderItems"
    
    func addItem(item: Reminder) { // persist a representation of this todo item in NSUserDefaults
        
        var reminderDictionary = NSUserDefaults.standardUserDefaults().dictionaryForKey(ITEMS_KEY) ?? Dictionary() // if todoItems hasn't been set in user defaults, initialize todoDictionary to an empty dictionary using nil-coalescing operator (??)
        
        reminderDictionary[item.UUID] = ["notificationTime": item.notificationTime, "busLocation": item.busLocation, "busTime": item.busTime]
        
        NSUserDefaults.standardUserDefaults().setObject(reminderDictionary, forKey: ITEMS_KEY) // save/overwrite todo item list
        
        // create a corresponding local notification
        var notification = UILocalNotification()
        notification.alertBody = "Bus Departing From: \(item.busLocation) At: \(item.busTime)"
        //notification.alertAction = "open" // text that is displayed after "slide to..." on the lock screen - defaults to "slide to view"
        notification.fireDate = item.notificationTime // todo item due date (when notification will be fired)
        notification.soundName = UILocalNotificationDefaultSoundName // play default sound
        notification.userInfo = ["UUID": item.UUID, ] // assign a unique identifier to the notification so that we can retrieve it later
        notification.category = "TODO_CATEGORY"
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
    func allItems() -> [Reminder] {
        var reminderDictionary = NSUserDefaults.standardUserDefaults().dictionaryForKey(ITEMS_KEY) ?? [:]
        let items = Array(reminderDictionary.values)
                
        var reminderArray: [Reminder] = []
        
        var keysArray: [String] = []
        
        
        for key in reminderDictionary.keys{
            
            let newKey: String = key as! String
            
            keysArray.append(newKey)
            
        }
        
        var i: Int = 0
        
        for item in items{
            
            var date: NSDate = item.objectForKey("notificationTime") as! NSDate
            var location: String = item.objectForKey("busLocation") as! String
            var time: String = item.objectForKey("busTime") as! String
            
            
            let key: String = keysArray[i]
            i++
            
            var newReminder: Reminder = Reminder(notificationTime: date, busLocation: location, busTime: time, UUID: key)
            
            reminderArray.append(newReminder)
        }
        
        return reminderArray
    }
    
    func removeItem(item: Reminder) {
        for notification in UIApplication.sharedApplication().scheduledLocalNotifications as! [UILocalNotification] { // loop through notifications...
            if (notification.userInfo!["UUID"] as! String == item.UUID) { // ...and cancel the notification that corresponds to this TodoItem instance (matched by UUID)
                UIApplication.sharedApplication().cancelLocalNotification(notification) // there should be a maximum of one match on UUID
                break
            }
        }
        
        if var currentReminders = NSUserDefaults.standardUserDefaults().dictionaryForKey(ITEMS_KEY) {
            currentReminders.removeValueForKey(item.UUID)
            NSUserDefaults.standardUserDefaults().setObject(currentReminders, forKey: ITEMS_KEY) // save/overwrite todo item list
        }
    }
    
    
    
}

