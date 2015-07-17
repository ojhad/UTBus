import Foundation

class Parser{
    class func getArrayOfTimesForDay(route: String, location: String, day: String) -> NSArray? {
        let bundle = NSBundle.mainBundle()
        let URL: NSURL?
        
        if(route=="St.George Route"){
            
            URL=bundle.URLForResource("routeStGeorge", withExtension: ".json");
        }
        else{
            URL=bundle.URLForResource("routeSheridan", withExtension: ".json");
        }
        
        let data: NSData? = NSData(contentsOfURL: URL!)
        
        var parseError: NSError?
        let parsedObject: AnyObject? = NSJSONSerialization.JSONObjectWithData(data!,
            options: NSJSONReadingOptions.AllowFragments,
            error:&parseError)
        
        if let main = parsedObject as? NSDictionary {
            if let place = main[location] as? NSDictionary {
                if let day = place[day] as? NSArray{
                    return day
                }
            }
        }
        
        return NSArray.new()
    }
    
    class func getDay() -> String{
        let date = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let day = dateFormatter.stringFromDate(date)
        
        return day
    }
    
    class func getFuture(times: NSArray) ->NSArray{
        var nextTimes = [String]()
        
        let date = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "HH:mm"
        let currentTime = formatter.stringFromDate(date)
        
        for var index=0; index<times.count; ++index{
            let temp: AnyObject = times[index]
            let realTime = temp["time"]
            let final = realTime as! String
            
            if currentTime.compare(final) == NSComparisonResult.OrderedAscending {
                nextTimes.append(final)
            }
        }
        
        return nextTimes as NSArray
    }
}