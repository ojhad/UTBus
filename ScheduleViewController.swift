//
//  ScheduleViewController.swift
//  UTBus
//
//  Created by Dilip Ojha on 2015-06-17.
//  Copyright (c) 2015 madlab. All rights reserved.
//

import Foundation
import UIKit

class ScheduleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tvLeft: UITableView!
    @IBOutlet weak var tvRight: UITableView!
    @IBOutlet weak var lblTitleLeft: UILabel!
    @IBOutlet weak var lblTitleRight: UILabel!
    
    var timeOfTappedCell: String?
    var locationOfTappedCell: String?
    
    
    var dataModel: ScheduleDataModel?
    
    var dataLeftTableView = ["6:10", "12:30", "18:15"]
    var dataRightTableView = ["8:50", "9:40", "10:10", "11:40"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //get Data
        
        let bundle = NSBundle.mainBundle()
        let URL: NSURL? = bundle.URLForResource("data", withExtension: ".json");
        let data: NSData? = NSData(contentsOfURL: URL!)
        
        dataModel = ScheduleDataModel(data: data ?? NSData())
        
        
        print(dataModel?.nextDeparture("mississauga"))
        
        
        
        //set up table views
        
        self.tvLeft.dataSource = self;
        self.tvLeft.delegate = self;

        
        self.tvRight.dataSource = self;
        self.tvRight.delegate = self;
        
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tvLeft{
            return dataLeftTableView.count
        }
        else{
            return dataRightTableView.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("timeCell", forIndexPath: indexPath) as! UITableViewCell
        
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.textLabel?.textAlignment = NSTextAlignment.Center;

        
        if tableView == self.tvLeft{
            
            cell.textLabel?.text = dataLeftTableView[indexPath.row]
            
        }
        else{
            
            cell.textLabel?.text = dataRightTableView[indexPath.row]

        }
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if (tableView == tvLeft){
            timeOfTappedCell = dataLeftTableView[indexPath.row]
            locationOfTappedCell = "Mississauga"
        }
        else{
            timeOfTappedCell = dataRightTableView[indexPath.row]
            locationOfTappedCell = lblTitleRight.text
        }
        
        self.performSegueWithIdentifier("create_notification", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "create_notification"){
            var VC: CreateReminderViewController = segue.destinationViewController as! CreateReminderViewController
            
            VC.busTime = timeOfTappedCell
            VC.busLocation = locationOfTappedCell
        }
    
    }
    
    @IBAction func changedSegmentedControl(sender: AnyObject) {
        
        var control: UISegmentedControl? = sender as! UISegmentedControl
        
        if (control?.selectedSegmentIndex == 0){
            lblTitleLeft.text = "Mississauga"
            lblTitleRight.text = "St. George"
        }
        else{
            lblTitleLeft.text = "Mississauga"
            lblTitleRight.text = "Sheridan"
        }
        
    }
    
    
    
}
