import UIKit

class HomeViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    let textCellIdentifier = "TextCell"
    
    var source: dataParser!
    var days: NSArray = []
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var ServiceUpdates: UITextView!
    
    @IBOutlet weak var segmentedControlRoutes: UISegmentedControl!
    
    //UTM or UTSG
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBAction func indexChanged(sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            days = source.getArrayOfTimesForDay("St. George", location: "Hart House (UTSG)", day: getDay())
        case 1:
            days = source.getArrayOfTimesForDay("Sheridan", location: "Sheridan", day: getDay())
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
        case 1:
            segmentedControl.setTitle("Deerfield Hall North", forSegmentAtIndex: 0)
            segmentedControl.setTitle("Sheridan College", forSegmentAtIndex: 1)
            
        default:
            break;
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        source = dataParser.new()
        days = source.getArrayOfTimesForDay("St. George", location: "Hart House (UTSG)", day: getDay())
        
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
            
            ServiceUpdates.text =  "\t\t\t\t\tService Updates\n\n" + serviceUpdates
        }
        
        //getFuture(getDay(), times: days)
    }
    
    
    func getDay() -> String{
        let date = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let day = dateFormatter.stringFromDate(date)
        
        return day.lowercaseString
    }
    
    func getFuture(day:String, times: NSArray){
        let date = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "HH:mm"
        let time = formatter.stringFromDate(date)
        
        
        for var index = 0; index < times.count; ++index {
            let temp: AnyObject = times[index]
            let realTimes = temp["time"]
            if(time>realTimes as! String){
                println(realTimes as! String)
            }
        }
    
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
        let temp: AnyObject = days[row]
        let time = temp["time"]

        cell.textLabel!.text = time as? String
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
    }
}