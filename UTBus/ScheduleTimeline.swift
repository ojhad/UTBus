//
//  ScheduleTimeline.swift
//  UTBus
//
//  Created by Mike Spears on 2015-06-15.
//  Copyright (c) 2015 madlab. All rights reserved.
//

import Foundation

class ScheduleTimeline {
    let dayOfWeek: NSDateComponents
    let timeline: Array<NSDateComponents>
    
    static var timeFormatter :NSDateFormatter = {
        let f = NSDateFormatter()
        f.dateFormat = "h:mm"
        return f
    }()
    
    static var weekdayMapper = ["sunday": 1, "monday": 2, "tuesday": 3, "wednesday": 4, "thursday": 5, "friday": 6, "saturday": 7]
    
    
    init (dayName: String, departureTimes: Array<Dictionary<String, String>>) {
        

        dayOfWeek = NSDateComponents()
        
        dayOfWeek.weekday = ScheduleTimeline.weekdayMapper[dayName.lowercaseString] ?? 0
        
        var newTimeline = Array<NSDateComponents>()
        
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        
        for timeDict in departureTimes {
            
            if let timeString = timeDict["time"] {
                
                
                
                if let date = ScheduleTimeline.timeFormatter.dateFromString(timeString) {
                    let timeComponents = calendar!.components(NSCalendarUnit.CalendarUnitHour | NSCalendarUnit.CalendarUnitMinute, fromDate: date)
                    
                    newTimeline.append(timeComponents)
                    
                }
                
            }
            
        }
        
        newTimeline.sort {
            return ($0.hour == $1.hour) ? ($0.minute < $1.minute) : ($0.hour < $1.hour)
        }

        
        timeline = newTimeline
        
    }
    
    func nextDepartureAfter (now: NSDate) -> NSDate? {
        
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let nowComponents = calendar.components(NSCalendarUnit.YearCalendarUnit | NSCalendarUnit.MonthCalendarUnit | NSCalendarUnit.DayCalendarUnit | NSCalendarUnit.WeekdayCalendarUnit | NSCalendarUnit.HourCalendarUnit | NSCalendarUnit.MinuteCalendarUnit, fromDate: now)
        
        
        var result :NSDate?
        
        // find the first item in the timeline that is in the future
        if nowComponents.weekday == self.dayOfWeek.weekday {
            for item in timeline {
                if (item.hour > nowComponents.hour) || ((item.hour == nowComponents.hour) && (item.minute > nowComponents.minute))
                {
                    nowComponents.hour = item.hour
                    nowComponents.minute = item.minute
                    result = calendar.dateFromComponents(nowComponents)
                    break
                    
                }
            }
        }

        
        return result
        
    }

}