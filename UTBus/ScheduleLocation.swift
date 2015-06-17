//
//  ScheduleLocation.swift
//  UTBus
//
//  Created by Mike Spears on 2015-06-15.
//  Copyright (c) 2015 madlab. All rights reserved.
//

import Foundation

class ScheduleLocation {
    let name: String
    let timelines: Array<ScheduleTimeline>
    
    init (name: String, timeData: Dictionary<String, AnyObject>) {
        self.name = name
        
        var newTimelines = Array<ScheduleTimeline>()
        
        for (dayName, timelineData) in timeData {
            if let timelineArray = timelineData as? Array<Dictionary<String, String>> {
                let newTimeline = ScheduleTimeline(dayName: dayName, departureTimes: timelineArray)
                newTimelines.append(newTimeline)
                
            }
        }
        timelines = newTimelines
    }
    

    
    func nextDepartureAfter(date: NSDate) -> NSDate? {
        var result :NSDate?
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        
        let nowComponents = calendar.components(NSCalendarUnit.WeekdayCalendarUnit, fromDate: date)
        
        
        
        for item in timelines {
            if nowComponents.weekday == item.dayOfWeek.weekday {
                result = item.nextDepartureAfter(date)
                break
            }
        }
        return result
    }
}
