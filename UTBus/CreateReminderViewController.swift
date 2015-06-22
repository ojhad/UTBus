//
//  CreateReminderViewController.swift
//  UTBus
//
//  Created by Dilip Ojha on 2015-06-22.
//  Copyright (c) 2015 madlab. All rights reserved.
//

import UIKit

class CreateReminderViewController: UITableViewController {
    
    @IBOutlet weak var bbtnCreate: UIBarButtonItem!
    
    var busTime: String?
    var busLocation: String?
    
    @IBOutlet weak var lblBusLocation: UILabel!
    @IBOutlet weak var lblBusTime: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = bbtnCreate
        self.navigationItem.title = "Reminder"
        
        lblBusTime.text = busTime
        lblBusLocation.text = busLocation
        
    }
    
    
    @IBAction func tappedCreate(sender: AnyObject) {
    }

}
