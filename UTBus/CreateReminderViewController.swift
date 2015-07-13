//
//  CreateReminderViewController.swift
//  UTBus
//
//  Created by Dilip Ojha on 2015-06-22.
//  Copyright (c) 2015 madlab. All rights reserved.
//

import UIKit

class CreateReminderViewController: UITableViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Info Requried From Source View Controllers
    
    var isNewReminder: Bool?
    
    //MARK: If Creating New Reminder
    
    var busTime: String?
    var busLocation: String?
    var dayOfWeek: String?
    
    //MARK: If Modifying Existing Reminder
    
   // var dateOfInterest: NSDate?
    
    var editReminder: Reminder?
    
    //MARK: - Variables Used by View Controller

    var timeOfNotification: NSDate?
    
    var dateOfBus: NSDate?
    
    var pickerVisible = false

    
    //MARK: - IBOutlets
    
    @IBOutlet weak var lblBusLocation: UILabel!
    @IBOutlet weak var lblBusTime: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var switchRepeat: UISwitch!
    @IBOutlet weak var lblSwitch: UILabel!
    
    @IBOutlet weak var deleteReminderCell: UITableViewCell!
    @IBOutlet var tvCreateReminder: UITableView!
    @IBOutlet weak var datePickerCell: UITableViewCell!
    @IBOutlet weak var cellRemindOnSpecificTime: UITableViewCell!
    
    @IBOutlet weak var ivArrow: UIImageView!
    //MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tvCreateReminder.dataSource = self
        self.tvCreateReminder.delegate = self
        
        self.navigationItem.title = "Reminder"
        
        ivArrow.image = UIImage(named: "arrow_right")
        
        if(isNewReminder == true){
            
            lblBusLocation.text = busLocation
            
            switchRepeat.on = false
            
            let bbtnCreate = UIBarButtonItem(title: "Create", style: .Plain, target: self, action: "tappedCreate")
            self.navigationItem.rightBarButtonItem = bbtnCreate
            
            
            //extract day of bus departue
            
            var today = NSDate()
            
            var dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "EEEE"
            var todaysDayOfTheWeek: String = dateFormatter.stringFromDate(today)
            
            if(todaysDayOfTheWeek == dayOfWeek){
                
                dateFormatter.dateFormat = "dd/MM/yy "
                let todayDateString = dateFormatter.stringFromDate(today)
                
                let busStringDate = todayDateString + busTime!
                
                dateFormatter.dateFormat = "dd/MM/yy HH:mm"
                
                let busDate = dateFormatter.dateFromString(busStringDate)
                
                dateOfBus = busDate
                
            }
            else{
                
                dateFormatter.dateFormat = "EEEE"
                
                var incrementDay: String = todaysDayOfTheWeek
                var incrementDate: NSDate = today
                
                while (incrementDay != dayOfWeek){
                    
                    incrementDate = incrementDate.dateByAddingTimeInterval(60*60*24)
                    incrementDay = dateFormatter.stringFromDate(incrementDate)
                    
                }
                
                dateFormatter.dateFormat = "dd/MM/yy "
                let todayDateString = dateFormatter.stringFromDate(incrementDate)
                
                let busStringDate = todayDateString + busTime!
                
                dateFormatter.dateFormat = "dd/MM/yy HH:mm"
                
                let busDate = dateFormatter.dateFromString(busStringDate)
                
                dateOfBus = busDate
                
            }
            
            datePicker.date = dateOfBus!

            dateFormatter.dateFormat = "EEEE MMM dd - hh:mm a"
            let displayDate: String = dateFormatter.stringFromDate(dateOfBus!)
            
            lblBusTime.text = displayDate
            
        }
        else{
            
            timeOfNotification = editReminder?.notificationTime
        
            lblBusLocation.text = editReminder?.busLocation
            
            if(editReminder?.repeat == true){
                switchRepeat.on = true
            }
            else{
                switchRepeat.on = false
            }
                
            let bbtnCreate = UIBarButtonItem(title: "Save", style: .Plain, target: self, action: "tappedCreate")
            self.navigationItem.rightBarButtonItem = bbtnCreate
            
            
            let date = editReminder?.notificationTime
            
            datePicker.setDate(date!, animated: true)
            
            var dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "EEEE"
            dayOfWeek = dateFormatter.stringFromDate(timeOfNotification!)
            
            //extract day of bus departue
            
            var today = NSDate()
            
            dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "EEEE"
            var todaysDayOfTheWeek: String = dateFormatter.stringFromDate(today)
            
            if(todaysDayOfTheWeek == dayOfWeek){
                
                dateFormatter.dateFormat = "dd/MM/yy "
                let todayDateString = dateFormatter.stringFromDate(today)
                
                let timeOfBus = editReminder?.busTime
                let busStringDate = todayDateString + timeOfBus!
                
                dateFormatter.dateFormat = "dd/MM/yy hh:mm a"
                
                let busDate = dateFormatter.dateFromString(busStringDate)
                
                dateOfBus = busDate
                
            }
            else{
                
                dateFormatter.dateFormat = "EEEE"
                
                var incrementDay: String = todaysDayOfTheWeek
                var incrementDate: NSDate = today
                
                while (incrementDay != dayOfWeek){
                    
                    incrementDate = incrementDate.dateByAddingTimeInterval(60*60*24)
                    incrementDay = dateFormatter.stringFromDate(incrementDate)
                    
                }
                
                dateFormatter.dateFormat = "dd/MM/yy "
                let todayDateString = dateFormatter.stringFromDate(incrementDate)
                
                let timeOfBus = editReminder?.busTime
                let busStringDate = todayDateString + timeOfBus!
                
                dateFormatter.dateFormat = "dd/MM/yy hh:mm a"
                
                let busDate = dateFormatter.dateFromString(busStringDate)
                
                dateOfBus = busDate
                
            }
            
            datePicker.date = dateOfBus!
            
            dateFormatter.dateFormat = "EEEE MMM dd - hh:mm a"
            let displayDate: String = dateFormatter.stringFromDate(dateOfBus!)
            
            lblBusTime.text = displayDate
            
            
        }
        
        lblSwitch.text = "Repeat Every \(dayOfWeek!)"
        
        timeOfNotification = dateOfBus
    }
    
    
    @IBAction func changedDatePicker(sender: AnyObject) {
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEEE"
        var dayString: String = dateFormatter.stringFromDate(datePicker.date)
        
        lblSwitch.text = "Repeat Every \(dayString)"
        
        timeOfNotification = datePicker.date
        
    }
    
    
    func tappedCreate(){
        
        if(isNewReminder == false){
            
            ReminderList.sharedInstance.removeItem(editReminder!)
            
        }
        
        let shouldRepeat = switchRepeat.on
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        let notificationBusTime: String = dateFormatter.stringFromDate(dateOfBus!)
        
        
        var newReminder: Reminder = Reminder(notificationTime: timeOfNotification!, busLocation: lblBusLocation.text!, busTime: notificationBusTime, UUID: NSUUID().UUIDString,repeat: shouldRepeat)
        
        ReminderList.sharedInstance.addItem(newReminder)
        
        self.navigationController?.popToRootViewControllerAnimated(true)
        
    }
    
    func setReminderTimeWithTime(minutes: Double){
        
        var newBusDate: NSDate = dateOfBus!.dateByAddingTimeInterval(-60*minutes)
        
        datePicker.setDate(newBusDate, animated:true)
        
        timeOfNotification = newBusDate
        
        self.tappedCreate()
        
        
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
    @IBAction func tappedRemindOnSpecificTime(sender: AnyObject) {
        
        pickerVisible = !pickerVisible
        
        if(pickerVisible == true){
            ivArrow.image = UIImage(named: "arrow_down")
        }
        else{
            ivArrow.image = UIImage(named: "arrow_right")
        }
        
        self.tvCreateReminder.reloadData()

        
    }
    
    @IBAction func tappedDeleteReminder(sender: AnyObject) {
        
        ReminderList.sharedInstance.removeItem(editReminder!)
                
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       
        /*println("SElected row!")
        
        if indexPath.section == 2 {
            ReminderList.sharedInstance.removeItem(editReminder!)
            
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)*/
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
       
        if(indexPath.section == 1){
            if(indexPath.row == 5){
                if (pickerVisible == false){
                    return 0.0
                }
                else{
                    return 193.0
                }
            }
            else if (indexPath.row == 0){
                return 80.0
            }
            else if (indexPath.row == 4){
                return 44.0
            }
            else{
                if (pickerVisible == false){
                    return 44.0
                }
                else{
                    return 0.0
                }
            }
        }
        
        
        if (indexPath.section == 2){
            if(self.isNewReminder == true){
                return 0.0
            }
            else{
                return 44.0
            }
        }

        return 44.0
    }
    
}
