//
//  SearchScheduleViewController.swift
//  UTBus
//
//  Created by Dilip Ojha on 2015-06-22.
//  Copyright (c) 2015 madlab. All rights reserved.
//

import UIKit

class SearchScheduleViewController: UIViewController {
    
    @IBOutlet weak var lblSelectedDate: UILabel!
    @IBOutlet weak var pickerDate: UIDatePicker!
    @IBOutlet weak var btnSetTodaysDate: UIButton!
    @IBOutlet weak var bbtnDone: UIBarButtonItem!
    
    var todaysDate: NSString?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set up UIDatePickers
        
        pickerDate.addTarget(self, action: Selector("pickerChangedDate"), forControlEvents: UIControlEvents.ValueChanged)

        //set up UI components
        
        btnSetTodaysDate.layer.cornerRadius = 10
        
        btnSetTodaysDate.backgroundColor = UIColor.blueColor()
        btnSetTodaysDate.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        
        self.navigationItem.rightBarButtonItem = bbtnDone
        
        
        //set lblSelectedDate and lblSelectedTime to today's date
        
        //selected date
        
        let currentDate = pickerDate.date;
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM dd, yyyy"
        var dateString = dateFormatter.stringFromDate(currentDate)
        
        lblSelectedDate.text = dateString;
        lblSelectedDate.textColor = UIColor.redColor()
        
        todaysDate = dateString;
        
    }
    
    func pickerChangedDate(){
        
        var newDate = pickerDate.date;
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM dd, yyyy"
        var dateString = dateFormatter.stringFromDate(newDate)
        
        lblSelectedDate.text = dateString;
        
        if (dateString == todaysDate){
            lblSelectedDate.textColor = UIColor.redColor()
            btnSetTodaysDate.backgroundColor = UIColor.blueColor()
            btnSetTodaysDate.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        }
        else{
            lblSelectedDate.textColor = UIColor.blueColor()
            btnSetTodaysDate.backgroundColor = UIColor.redColor()
            btnSetTodaysDate.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        }
        
        
    }
    
    @IBAction func tappedButtonSetTodaysDate(sender: AnyObject) {
        
        let date = NSDate()
        
        pickerDate.setDate(date, animated: true)
        
        self.pickerChangedDate()
        
    }

    @IBAction func bbtnDoneTapped(sender: AnyObject) {
        print("tappedDONE")
    }
}
