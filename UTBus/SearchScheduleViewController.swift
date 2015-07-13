//
//  SearchScheduleViewController.swift
//  UTBus
//
//  Created by Dilip Ojha on 2015-06-22.
//  Copyright (c) 2015 madlab. All rights reserved.
//

import UIKit

class SearchScheduleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    //MARK: - IBOUTLETS

    @IBOutlet weak var segControlRoute: UISegmentedControl!
    @IBOutlet weak var segControlLocation: UISegmentedControl!
    
    @IBOutlet weak var tvDaySelector: UITableView!
    
    //MARK: - Variables
    
    var todaysDate: NSString?
    
    var daysOfTheWeek: [String] = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
    
    var selectedDay: String = "Monday"
    
    //MARK: - Internal Logic
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set up day selector tableview
        
        tvDaySelector.delegate = self
        tvDaySelector.dataSource = self
        
        tvDaySelector.separatorStyle = UITableViewCellSeparatorStyle.None
    
        //customized segmented control
        
        segControlRoute.setBackgroundImage(UIImage(contentsOfFile: "blue_segment.png"), forState: UIControlState.Selected, barMetrics: UIBarMetrics.Default)
        
    }

    @IBAction func changedSegmentedControlRoute(sender: AnyObject) {
        switch segControlRoute.selectedSegmentIndex
        {
        case 0:
            segControlLocation.setTitle("Instructional Centre (UTM)", forSegmentAtIndex: 0)
            segControlLocation.setTitle("Hart House (UTSG)", forSegmentAtIndex: 1)
        case 1:
            segControlLocation.setTitle("Deerfield Hall North", forSegmentAtIndex: 0)
            segControlLocation.setTitle("Sheridan", forSegmentAtIndex: 1)
            
        default:
            break;
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "show_detail_schedule"{
            
            var vc: ScheduleTableViewController = segue.destinationViewController as! ScheduleTableViewController
            
            let indexRoute = segControlRoute.selectedSegmentIndex
            let indexLocation = segControlLocation.selectedSegmentIndex

            
            vc.currentRoute = segControlRoute.titleForSegmentAtIndex(indexRoute)!
            vc.currentLocation = segControlLocation.titleForSegmentAtIndex(indexLocation)!
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
