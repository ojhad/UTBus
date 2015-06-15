//
//  dataParser.swift
//  UTBus
//
//  Created by Dilip Ojha on 2015-06-15.
//  Copyright (c) 2015 madlab. All rights reserved.
//

import Foundation

class dataParser: NSObject {
    
    func getArrayOfTimesForDay(getDay: String) -> NSArray {
        
        let bundle = NSBundle.mainBundle()
        let URL: NSURL? = bundle.URLForResource("data", withExtension: ".json");
        let data: NSData? = NSData(contentsOfURL: URL!)
        
        var parseError: NSError?
        let parsedObject: AnyObject? = NSJSONSerialization.JSONObjectWithData(data!,
            options: NSJSONReadingOptions.AllowFragments,
            error:&parseError)
        
        if let main = parsedObject as? NSDictionary {
            if let route = main["mississauga"] as? NSDictionary {
                if let day = route[getDay] as? NSArray{
                     return day
                }
            }
        }
        
        let temp: NSArray = NSArray.new()
        
        return temp

    }
    
}