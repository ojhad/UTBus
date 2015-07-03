//
//  SearchScheduleViewController.swift
//  UTBus
//
//  Created by Dilip Ojha on 2015-06-22.
//  Copyright (c) 2015 madlab. All rights reserved.
//

import UIKit

class SearchScheduleViewController: UIViewController {
    
    @IBOutlet weak var pickerDate: UIDatePicker!
    @IBOutlet weak var btnSetTodaysDate: UIButton!
    @IBOutlet weak var segControlRoute: UISegmentedControl!
    @IBOutlet weak var segControlLocation: UISegmentedControl!
    @IBOutlet weak var btnSearch: UIButton!
    
    var todaysDate: NSString?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set up UIDatePickers
        
        pickerDate.addTarget(self, action: Selector("pickerChangedDate"), forControlEvents: UIControlEvents.ValueChanged)

        //set up UI components
        
        btnSetTodaysDate.layer.cornerRadius = 10
        btnSetTodaysDate.layer.borderColor = UIColor.blackColor().CGColor
        btnSetTodaysDate.layer.borderWidth = 3.0
        
        btnSetTodaysDate.backgroundColor = UIColor.whiteColor()
        btnSetTodaysDate.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        
        btnSearch.layer.cornerRadius = 10;
        btnSearch.backgroundColor =  UIColor(red:0.0, green:0.18, blue:0.4, alpha:1.0);
        
        btnSetTodaysDate.alpha = 0.0;
        btnSetTodaysDate.enabled = false;
        
        //selected date
        
        let currentDate = pickerDate.date;
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM dd, yyyy"
        var dateString = dateFormatter.stringFromDate(currentDate)
        
        todaysDate = dateString;
        
        //customized segmented control
        
        segControlRoute.setBackgroundImage(UIImage(contentsOfFile: "blue_segment.png"), forState: UIControlState.Selected, barMetrics: UIBarMetrics.Default)
        
    }
    
    func pickerChangedDate(){
        
        var newDate = pickerDate.date;
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM dd, yyyy"
        var dateString = dateFormatter.stringFromDate(newDate)
        
        
        if (dateString == todaysDate){
            
            UIView.animateWithDuration(0.5, animations: {
                self.btnSetTodaysDate.alpha = 0.0
                self.btnSetTodaysDate.enabled = false;
            })
            
        }
        else{
            
            UIView.animateWithDuration(0.5, animations: {
                self.btnSetTodaysDate.alpha = 1.0
                self.btnSetTodaysDate.enabled = true;
            })
           
        }
        
        
    }
    
    @IBAction func tappedButtonSetTodaysDate(sender: AnyObject) {
        
        let date = NSDate()
        
        pickerDate.setDate(date, animated: true)
        
        self.pickerChangedDate()
        
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
            vc.dateOfInterest = pickerDate.date
            
            
        }
    }

}
