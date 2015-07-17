//
//  RoutesTableViewController.swift
//  UTBus
//
//  Created by Dilip Ojha on 2015-07-17.
//  Copyright (c) 2015 madlab. All rights reserved.
//

import UIKit

class RoutesTableViewController: UITableViewController {
    
    var selectedRoute: String?
    var selectedLocation: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.tableView.separatorStyle = .None
        
        self.navigationItem.title = "Schedule"
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.section == 0{
            
            selectedRoute = "St.George Route"
            
            if indexPath.row == 0{
                selectedLocation = "Instructional Centre";
            }
            else{
                selectedLocation = "Hart House";
            }
            
        }
        else if indexPath.section == 1{
            
            selectedRoute = "Sheridan Route"
            
            if indexPath.row == 0{
                selectedLocation = "Deerfield Hall North";
            }
            else{
                selectedLocation = "Sheridan";
            }
            
        }
        
        self.performSegueWithIdentifier("show_days", sender: self)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
        var vc: SearchScheduleViewController = segue.destinationViewController as! SearchScheduleViewController
        vc.selectedRoute = self.selectedRoute
        vc.selectedLocation = self.selectedLocation
        
    }

}
