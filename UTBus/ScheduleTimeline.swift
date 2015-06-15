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
    
    init (dayName: String, departureTimes: Array<Dictionary<String, String>>) {
        
        dayOfWeek = NSDateComponents()
        
        let mapper = ["sunday": 1, "monday": 2, "tuesday": 3, "wednesday": 4, "thursday": 5, "friday": 6, "saturday": 7]
        
        dayOfWeek.weekday = mapper[dayName] ?? 0
        
        var newTimeline = Array<NSDateComponents>()
        
        
        for timeDict in departureTimes {
            let timeString :String? = timeDict["time"]
            
            var timeComponents = NSDateComponents()
            
            
            // TODO: translate string time into an hour and minute
            
            newTimeline.append(timeComponents)
            
        }
        
        // TODO: sort timeline by hour/minute
        
        timeline = newTimeline
        
    }
    

}