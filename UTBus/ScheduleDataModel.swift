//
//  ScheduleDataModel.swift
//  UTBus
//
//  Created by Mike Spears on 2015-06-15.
//  Copyright (c) 2015 madlab. All rights reserved.
//

import Foundation

class ScheduleDataModel {
    
    let locations: Array<ScheduleLocation>
    
    init (data: NSData) {
        var parseError: NSError?
        let parsedObject: AnyObject? = NSJSONSerialization.JSONObjectWithData(data,
            options: NSJSONReadingOptions.AllowFragments,
            error:&parseError)
        
        
        var newLocations = Array<ScheduleLocation>()
        
        if let route = parsedObject as? Dictionary<String, AnyObject> {
            for (locationName, details) in route {
                if let detailsDict = details as? Dictionary<String, AnyObject> {
                    let newLocation = ScheduleLocation(name: locationName, timeData: detailsDict)
                    newLocations.append(newLocation)
                }
            }
        }
        
        
        
        locations = newLocations
        
        
        
        
        
    }
}