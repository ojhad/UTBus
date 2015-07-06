//
//  CreateReminderViewController.swift
//  UTBus
//
//  Created by Dilip Ojha on 2015-06-22.
//  Copyright (c) 2015 madlab. All rights reserved.
//

import UIKit

class CreateReminderViewController: UITableViewController {
    
    var busTime: String?
    var busLocation: String?
    
    var dateOfInterest: NSDate?
    
    var editReminder: Reminder?
    
    var isNewReminder: Bool?
    
    @IBOutlet weak var lblBusLocation: UILabel!
    @IBOutlet weak var lblBusTime: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var switchRepeat: UISwitch!
    @IBOutlet weak var lblSwitch: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Reminder"
        
        if(isNewReminder == true){
        
        lblBusTime.text = busTime
        lblBusLocation.text = busLocation
        
        let bbtnCreate = UIBarButtonItem(title: "Create", style: .Plain, target: self, action: "tappedCreate")
        self.navigationItem.rightBarButtonItem = bbtnCreate

            
        }
        else{
            
        busTime = editReminder?.busTime
        busLocation = editReminder?.busLocation
        dateOfInterest = editReminder?.notificationTime
            
        lblBusTime.text = editReminder?.busTime
        lblBusLocation.text = editReminder?.busLocation
            
        let date = editReminder?.notificationTime
            
        datePicker.setDate(date!, animated: true)
            
        let bbtnCreate = UIBarButtonItem(title: "Save", style: .Plain, target: self, action: "tappedCreate")
        self.navigationItem.rightBarButtonItem = bbtnCreate
            
            
        }
        
        if(editReminder?.repeat == true){
            switchRepeat.on = true
        }
        else{
            switchRepeat.on = false
        }
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEEE"
        var dayString: String = dateFormatter.stringFromDate(datePicker.date)
        
        lblSwitch.text = "Repeat Every \(dayString)"
        
        
    }
    
    
    @IBAction func changedDatePicker(sender: AnyObject) {
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEEE"
        var dayString: String = dateFormatter.stringFromDate(datePicker.date)
        
        lblSwitch.text = "Repeat Every \(dayString)"
        
        
    }
    
    
    func tappedCreate(){
        
        if(isNewReminder == false){
            
            ReminderList.sharedInstance.removeItem(editReminder!)
            
        }
        
        var newDate = datePicker.date;
        
        let shouldRepeat = switchRepeat.on
        
        var newReminder: Reminder = Reminder(notificationTime: newDate, busLocation: lblBusLocation.text!, busTime: lblBusTime.text!, UUID: NSUUID().UUIDString,repeat: shouldRepeat)
        
        ReminderList.sharedInstance.addItem(newReminder)
        
        self.navigationController?.popToRootViewControllerAnimated(true)
        
    }
    
    func setReminderTimeWithTime(minutes: Double){
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        var time: NSDate = dateFormatter.dateFromString(busTime!)!
        
        var newTime = time.dateByAddingTimeInterval(-60*minutes)
        
        var requiredTime: String? = dateFormatter.stringFromDate(newTime)
        
        dateFormatter.dateFormat = "MM:dd:yyyy"
        var requiredDay: String? = dateFormatter.stringFromDate(dateOfInterest!)
        
        let finalDateString: String? = requiredDay! + ":" + requiredTime!
        
        dateFormatter.dateFormat = "MM:dd:yyyy:HH:mm"
        
        let finalDate: NSDate? = dateFormatter.dateFromString(finalDateString!)
        
        datePicker.setDate(finalDate!, animated: true)
    }
    
    @IBAction func tappedRemind30MinutesBefore(sender: AnyObject) {
        
        self.setReminderTimeWithTime(30);
        
    }
    
    @IBAction func tappedRemind1HourBefore(sender: AnyObject) {
        
        self.setReminderTimeWithTime(60);
        
    }
    
    @IBAction func tappedRemind2HoursBefore(sender: AnyObject) {
        
        self.setReminderTimeWithTime(120);
        
    }
    
}
