import Foundation

class dataParser: NSObject {
    
    func getArrayOfTimesForDay(day: String, route: String) -> NSArray {
        let bundle = NSBundle.mainBundle()
        let URL: NSURL?
        
        
        if(route=="St. George"){
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
            if let route = main[route] as? NSDictionary {
                if let day = route[day] as? NSArray{
                     return day
                }
            }
        }
        
        let temp: NSArray = NSArray.new()
        
        return temp

    }
    
}