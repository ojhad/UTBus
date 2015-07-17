import UIKit

class HomeViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    let textCellIdentifier = "TextCell"
    
    var schedule: NSArray = []
    
    var timeOfTappedCell: String?
    var departingLocationOfTappedCell: String?
    var dayOfTheWeek: String?
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var segmentedControlRoutes: UISegmentedControl!
    
    @IBOutlet weak var segmentedControlLocations: UISegmentedControl!
    
    
    @IBAction func indexChangedRoutes(sender: UISegmentedControl) {
        switch segmentedControlRoutes.selectedSegmentIndex
        {
        case 0:
            
            if segmentedControlLocations.selectedSegmentIndex==0{
                schedule =
                    Parser.getFuture(Parser.getArrayOfTimesForDay("St.George Route", location: "Hart House", day: Parser.getDay())!)
            }
            else{
                schedule =
                    Parser.getFuture(Parser.getArrayOfTimesForDay("St.George Route", location: "Instructional Centre", day: Parser.getDay())!)
            }
            
            segmentedControlLocations.setTitle("Hart House", forSegmentAtIndex: 0)
            segmentedControlLocations.setTitle("Instructional Centre", forSegmentAtIndex: 1)
            
        case 1:
            if segmentedControlLocations.selectedSegmentIndex==0{
                schedule =
                    Parser.getFuture(Parser.getArrayOfTimesForDay("Sheridan Route", location: "Deerfield Hall North", day: Parser.getDay())!)
            }
            else{
                schedule =
                    Parser.getFuture(Parser.getArrayOfTimesForDay("Sheridan Route", location: "Sheridan", day: Parser.getDay())!)
            }
            
            segmentedControlLocations.setTitle("Deerfield Hall North", forSegmentAtIndex: 0)
            segmentedControlLocations.setTitle("Sheridan College", forSegmentAtIndex: 1)
        default:
            break;
        }
        
        self.tableView.reloadData()
    }
    
    
    
    @IBAction func indexChangedLocations(sender: AnyObject) {
        switch segmentedControlLocations.selectedSegmentIndex
        {
        case 0:
            if segmentedControlRoutes.selectedSegmentIndex==0{
                schedule =
                    Parser.getFuture(Parser.getArrayOfTimesForDay("St.George Route", location: "Hart House", day: Parser.getDay())!)
            }
            else{
                schedule =
                    Parser.getFuture(Parser.getArrayOfTimesForDay("Sheridan Route", location: "Sheridan", day: Parser.getDay())!)
            }
            
        case 1:
            if segmentedControlRoutes.selectedSegmentIndex==0{
                schedule =
                    Parser.getFuture(Parser.getArrayOfTimesForDay("St.George Route", location: "Instructional Centre", day: Parser.getDay())!)
            }
            else{
                schedule =
                    Parser.getFuture(Parser.getArrayOfTimesForDay("Sheridan Route", location: "Deerfield Hall North", day: Parser.getDay())!)
            }
        default:
            break;
        }
        
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        schedule =
            Parser.getFuture(Parser.getArrayOfTimesForDay("St.George Route", location: "Hart House", day: Parser.getDay())!)
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        var backgroundView = UIView(frame: CGRectZero)
        
        self.tableView.tableFooterView = backgroundView
        
        self.tableView.backgroundColor = UIColor.clearColor()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(schedule.count==0){
            var empty = UILabel(frame: CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height))
            empty.font=UIFont(name:"Palatino-Italic", size:24)
            
            empty.textAlignment = NSTextAlignment.Center
            empty.text = "No buses currently available"
            self.tableView.backgroundView=empty
        
            return 0
        }
        else{
            return schedule.count
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as! UITableViewCell
        
        let row = indexPath.row
        
        cell.textLabel!.text = schedule[row] as? String
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let currentCell = tableView.cellForRowAtIndexPath(indexPath);
        timeOfTappedCell = currentCell!.textLabel!.text
        
        if segmentedControlRoutes.selectedSegmentIndex==0{
            if segmentedControlLocations.selectedSegmentIndex==0{
                departingLocationOfTappedCell = "Hart House"
                
            }
            else{
                departingLocationOfTappedCell = "Instructional Centre"
            }
        }
        else{
            if segmentedControlRoutes.selectedSegmentIndex==0{
                departingLocationOfTappedCell = "Deerfield Hall North"
            }
            else{
                departingLocationOfTappedCell = "Sheridan"
            }
        }
        
        let dateOfInterest = NSDate()
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEEE"
        dayOfTheWeek = dateFormatter.stringFromDate(dateOfInterest)
        
        self.performSegueWithIdentifier("create_reminder", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "create_reminder"{
        
            var vc: CreateReminderViewController = segue.destinationViewController as! CreateReminderViewController
            
            vc.isNewReminder = true
            vc.busTime = timeOfTappedCell
            vc.busLocation = departingLocationOfTappedCell
            vc.dayOfWeek = dayOfTheWeek
        }
    }
}