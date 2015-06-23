import UIKit

class HomeViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    var source: dataParser!
    var days: NSArray = []
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var segmentedControlRoutes: UISegmentedControl!
    //UTM or UTSG
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBAction func indexChanged(sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            days=source.getArrayOfTimesForDay("monday")
        case 1:
            days=source.getArrayOfTimesForDay("saturday")
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
            segmentedControl.setTitle("Sheridan", forSegmentAtIndex: 1)
            
        default:
            break;
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        source = dataParser.new()
        days=source.getArrayOfTimesForDay("monday")
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TextCell", forIndexPath: indexPath) as! UITableViewCell
        
        let row = indexPath.row
        let temp: AnyObject = days[row]
        let time = temp["time"]
        cell.textLabel!.text = time as? String
        
        return cell
    }
}