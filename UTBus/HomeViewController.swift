import UIKit

class HomeViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    let textCellIdentifier = "TextCell"
    let textCellIdentifier2 = "TextCell2"
    
    var source: dataParser!
    var schedule: NSArray = []
    var schedule2: NSArray = []
    
    var timeOfTappedCell: String?
    var departingLocationOfTappedCell: String?
    var dateOfInterest: NSDate?


    @IBOutlet weak var label1: UILabel!
    
    @IBOutlet weak var label2: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var tableView2: UITableView!
    
    @IBOutlet weak var segmentedControlRoutes: UISegmentedControl!
    
    @IBAction func indexChangedRoutes(sender: UISegmentedControl) {
        switch segmentedControlRoutes.selectedSegmentIndex
        {
        case 0:
            
            schedule =
                getFuture(getDay(), times: source.getArrayOfTimesForDay("St.George Route", location: "Instructional Centre", day: getDay()))
        
            schedule2 = getFuture(getDay(), times: source.getArrayOfTimesForDay("St.George Route", location: "Hart House", day: getDay()))
            
            label1.text="Departing from Instructional Centre"
            label2.text="Departing from Hart House"
            
        case 1:
            
            schedule = getFuture(getDay(), times: source.getArrayOfTimesForDay("Sheridan Route", location: "Deerfield Hall North", day: getDay()))
           
            schedule2 = getFuture(getDay(), times: source.getArrayOfTimesForDay("Sheridan Route", location: "Sheridan", day: getDay()))
            
            label1.text="Departing from Deerfield Hall North"
            label2.text="Departing from Sheridan"
            
        default:
            break;
        }
        
        self.tableView.reloadData()
        self.tableView2.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        source = dataParser.new()
        
        schedule =
            getFuture(getDay(), times: source.getArrayOfTimesForDay("St.George Route", location: "Instructional Centre", day: getDay()))
        
        schedule2 = getFuture(getDay(), times: source.getArrayOfTimesForDay("St.George Route", location: "Hart House", day: getDay()))
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView2.delegate = self
        tableView2.dataSource = self
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
            
            if currentTime.compare(final) == NSComparisonResult.OrderedAscending && count<5 {
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
        return schedule.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tableView.isEqual(self.tableView){
            let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as! UITableViewCell
            
            let row = indexPath.row
            
            cell.textLabel!.text = schedule[row] as? String
            
            return cell
        
        }
        else{
            let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier2, forIndexPath: indexPath) as! UITableViewCell
            
            let row = indexPath.row
            
            cell.textLabel!.text = schedule2[row] as? String
            
            return cell
        
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let currentCell = tableView.cellForRowAtIndexPath(indexPath);
        timeOfTappedCell = currentCell!.textLabel!.text
        
        if tableView.isEqual(self.tableView){
            if segmentedControlRoutes.selectedSegmentIndex==0{
                departingLocationOfTappedCell = "Instructional Centre"
            }
            else{
                departingLocationOfTappedCell = "Deerfield Hall North"
            }
        }
        else{
            if segmentedControlRoutes.selectedSegmentIndex==0{
                departingLocationOfTappedCell = "Hart House"
            }
            else{
                departingLocationOfTappedCell = "Sheridan"
            }
        }
        
        dateOfInterest = NSDate()
        
        self.performSegueWithIdentifier("create_reminder", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "create_reminder"{
        
            var vc: CreateReminderViewController = segue.destinationViewController as! CreateReminderViewController
            
            vc.isNewReminder = true
            vc.busTime = timeOfTappedCell
            vc.busLocation = departingLocationOfTappedCell
            vc.dateOfInterest = dateOfInterest
        }
    }
}