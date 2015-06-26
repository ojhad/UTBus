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
    
    @IBOutlet weak var lblBusLocation: UILabel!
    @IBOutlet weak var lblBusTime: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Reminder"
        
        lblBusTime.text = busTime
        lblBusLocation.text = busLocation
        
        let bbtnCreate = UIBarButtonItem(title: "Create", style: .Plain, target: self, action: "tappedCreate")

        self.navigationItem.rightBarButtonItem = bbtnCreate
        
        
    }
    
    func tappedCreate(){
        
        var newDate = datePicker.date;
        
        var newReminder: Reminder = Reminder(notificationTime: newDate, busLocation: lblBusLocation.text!, busTime: lblBusTime.text!, UUID: NSUUID().UUIDString)
        
        ReminderList.sharedInstance.addItem(newReminder)
        
        self.navigationController?.popToRootViewControllerAnimated(true)
        
    }
    

}
