//
//  ScheduleTableViewController.swift
//  UTBus
//
//  Created by Dilip Ojha on 2015-06-29.
//  Copyright (c) 2015 madlab. All rights reserved.
//

import UIKit

class ScheduleTableViewController: UITableViewController {
    
    var dataTableView: NSArray = []
    
    var currentRoute: String = ""
    var currentLocation: String = ""

    
    var timeOfTappedCell: String = ""
    
    var dateOfInterest: NSDate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.navigationItem.title = currentLocation
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEEE"
        var dayString: String = dateFormatter.stringFromDate(dateOfInterest!)
                
        dataTableView = Parser.getArrayOfTimesForDay(currentRoute, location: currentLocation, day: dayString)
        
        if(dataTableView.count == 0){
            showAlert("No Bus Times Available!", message: "There are no bus times for \(dayString).")
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return dataTableView.count
    }
  
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let temp: AnyObject = dataTableView[indexPath.row]
        let time = temp["time"]
        timeOfTappedCell = (time as? String)!
        
        self.performSegueWithIdentifier("create_reminder", sender: self)
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell
        
        let temp: AnyObject = dataTableView[indexPath.row]
        let time = temp["time"]

        cell.textLabel!.text = time as? String
    
        return cell
    }
    
    // MARK: - Alert
    
    func showAlert(title: String, message: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        let defaultActionHandler = { (action:UIAlertAction!) -> Void in
            self.navigationController?.popToRootViewControllerAnimated(true)
        }
        
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: defaultActionHandler)
        
        alert.addAction(defaultAction)
        
        
        
        presentViewController(alert, animated: true, completion: nil)

        
    }

    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "create_reminder"{
            
            var vc: CreateReminderViewController = segue.destinationViewController as! CreateReminderViewController
            
            vc.isNewReminder = true
            vc.busTime = timeOfTappedCell
            vc.busLocation = currentLocation
            vc.dateOfInterest = self.dateOfInterest
        }
        
    }
}
