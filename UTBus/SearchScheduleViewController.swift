//
//  SearchScheduleViewController.swift
//  UTBus
//
//  Created by Dilip Ojha on 2015-06-22.
//  Copyright (c) 2015 madlab. All rights reserved.
//

import UIKit

class SearchScheduleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var selectedRoute: String?
    var selectedLocation: String?
    
    @IBOutlet weak var tvDaySelector: UITableView!
    
    //MARK: - Variables
    
    var todaysDate: NSString?
    
    var daysOfTheWeek: [String] = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
    
    var selectedDay: String = "Monday"
    
    //MARK: - Internal Logic
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = selectedLocation
        
        //set up day selector tableview
        
        tvDaySelector.delegate = self
        tvDaySelector.dataSource = self
        
        tvDaySelector.separatorStyle = UITableViewCellSeparatorStyle.None
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "show_detail_schedule"{
            
            var vc: ScheduleTableViewController = segue.destinationViewController as! ScheduleTableViewController
            
            vc.currentRoute = selectedRoute!
            vc.currentLocation = selectedLocation!
            vc.selectedDay = selectedDay
            
            
        }
    }
    
//MARK: - TableView Delegate and DataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return daysOfTheWeek.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("day_cell", forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel?.text = daysOfTheWeek[indexPath.row];
        
        return cell;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedDay = daysOfTheWeek[indexPath.row]
        self.performSegueWithIdentifier("show_detail_schedule", sender: self)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

}
