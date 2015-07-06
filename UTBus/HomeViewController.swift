import UIKit

class HomeViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    let textCellIdentifier = "TextCell"
    
    var source: dataParser!
    var days: NSArray = []
    
    //St. George
    var route=1
    var location=1
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var ServiceUpdates: UITextView!
    
    @IBOutlet weak var segmentedControlRoutes: UISegmentedControl!
    
    //UTM or UTSG
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBAction func indexChanged(sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            if route==1 {
                days =
                getFuture(getDay(), times: source.getArrayOfTimesForDay("St.George Route", location: "Instructional Centre (UTM)", day: getDay()))
            }
            else{
               days =
                getFuture(getDay(), times: source.getArrayOfTimesForDay("Sheridan Route", location: "Deerfield Hall North", day: getDay()))
            }
            
            location=1
            
        case 1:
            
            if route==1 {
                days =
                 getFuture(getDay(), times: source.getArrayOfTimesForDay("St.George Route", location: "Hart House (UTSG)", day: getDay()))
            }
            else{
                days =
                getFuture(getDay(), times: source.getArrayOfTimesForDay("Sheridan Route", location: "Sheridan", day: getDay()))
            }
            
            location=2
            
        default:
            break;
        }
        
        self.tableView.reloadData()
    }
    
    @IBAction func indexChangedRoutes(sender: UISegmentedControl) {
        switch segmentedControlRoutes.selectedSegmentIndex
        {
        case 0:
            
            segmentedControl.setTitle("Instructional Centre (UTM)", forSegmentAtIndex: 0)
            segmentedControl.setTitle("Hart House (UTSG)", forSegmentAtIndex: 1)
            route=1
            
            if location==1 {
                days =
                getFuture(getDay(), times: source.getArrayOfTimesForDay("St.George Route", location: "Instructional Centre (UTM)", day: getDay()))
            }
            else{
                
                
                days = getFuture(getDay(), times: source.getArrayOfTimesForDay("St.George Route", location: "Hart House (UTSG)", day: getDay()))
            }
            
        case 1:
            segmentedControl.setTitle("Deerfield Hall North", forSegmentAtIndex: 0)
            segmentedControl.setTitle("Sheridan College", forSegmentAtIndex: 1)
            route=2
            
            
            if location==1 {
                days = getFuture(getDay(), times: source.getArrayOfTimesForDay("Sheridan Route", location: "Deerfield Hall North", day: getDay()))
                
            }
            else{
                days = getFuture(getDay(), times: source.getArrayOfTimesForDay("Sheridan Route", location: "Sheridan", day: getDay()))
                
            }
            
        default:
            break;
        }
        
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.view.backgroundColor = UIColor(red:0.0, green:0.18, blue:0.4, alpha:1.0)
        
        source = dataParser.new()
        
        days=getFuture(getDay(), times: source.getArrayOfTimesForDay("St.George Route", location: "Instructional Centre (UTM)", day: getDay()))
        
        println(days)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let url = NSURL(string: "https://m.utm.utoronto.ca/shuttle.php")
        var error: NSError?
        let html = NSString(contentsOfURL: url!, encoding: NSUTF8StringEncoding, error: &error)
        
        if (error != nil) {
            ServiceUpdates.text =  "\t\t\t\t\tService Updates\n\nSomething went wrong..."
        } else {
            let start=html!.rangeOfString("<div class='notice'>").location
                + html!.rangeOfString("<div class='notice'>").length
            
            let substring: NSString = html!.substringFromIndex(start)
            let end=substring.rangeOfString("</div>").location
            
            var serviceUpdates=substring.substringToIndex(end)
            
            serviceUpdates=serviceUpdates.stringByReplacingOccurrencesOfString("// ", withString: "\n\n", options: NSStringCompareOptions.LiteralSearch, range: nil)
            
            ServiceUpdates.text = serviceUpdates
        }
        
        
    }
    
    
    func getDay() -> String{
        let date = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let day = dateFormatter.stringFromDate(date)
        
        return day
    }
    
    func getFuture(day:String, times: NSArray) ->NSArray{
        var nextTimes = [String]()
        
        let date = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "HH:mm"
        let currentTime = formatter.stringFromDate(date)
        
        var count=0
        
        for var index=0; index<times.count; ++index{
            let temp: AnyObject = times[index]
            let realTime = temp["time"]
            let final = realTime as! String
            
            if currentTime.compare(final) == NSComparisonResult.OrderedAscending && count<3{
                nextTimes.append(final)
                ++count
            }
        }
    
        return nextTimes as NSArray
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as! UITableViewCell
        
        let row = indexPath.row

        cell.textLabel!.text = days[row] as? String
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
    }
}