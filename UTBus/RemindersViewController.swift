//
//  RemindersViewController.swift
//  UTBus
//
//  Created by Dilip Ojha on 2015-06-26.
//  Copyright (c) 2015 madlab. All rights reserved.
//

import UIKit

class RemindersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var currentReminders: [Reminder] = []
    
    var editReminder: Reminder?

    @IBOutlet weak var tvReminders: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var background: UIImageView = UIImageView.new()
        background.frame = self.view.frame
        background.backgroundColor = UIColor.blackColor()
        background.image = UIImage(named: "utm3")
        background.contentMode = UIViewContentMode.ScaleAspectFill
        
        self.view.addSubview(background)
        self.view.sendSubviewToBack(background)
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshList", name: "ReminderListShouldRefresh", object: nil)
        
        tvReminders.dataSource = self;
        tvReminders.delegate = self;
        
        tvReminders.backgroundView?.backgroundColor = UIColor.clearColor()
        tvReminders.backgroundColor = UIColor.clearColor()
        
        tvReminders.separatorStyle = UITableViewCellSeparatorStyle.None
        
        tvReminders.registerNib(UINib(nibName: "ReminderTableViewCell", bundle: nil), forCellReuseIdentifier: "reminderCell")
    

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        refreshList()
    }

    func refreshList() {
        currentReminders = ReminderList.sharedInstance.allItems()
        if (currentReminders.count >= 64) {
            println("Maximum Set Notifications Reached!")
        }
        tvReminders.reloadData()
    }

    // MARK: - Table view data source
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true // all cells are editable
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            // delete the row from the data source
            var item = currentReminders.removeAtIndex(indexPath.row)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            ReminderList.sharedInstance.removeItem(item)
            
        }
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return currentReminders.count
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reminderCell", forIndexPath: indexPath) as! ReminderTableViewCell
        
        var item: Reminder = currentReminders[indexPath.row]
        
        cell.lblTitle.text = "Departing \(item.busLocation) at \(item.busTime)"
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "'Set For' MMM dd 'at' h:mm a"
        cell.lblSubtitle.text = dateFormatter.stringFromDate(item.notificationTime)
        
        
        cell.contentView.backgroundColor = UIColor.clearColor()
        cell.backgroundView?.backgroundColor = UIColor.clearColor()
        cell.backgroundColor = UIColor.clearColor()
        
        var whiteCard: UIImageView = UIImageView.new()
        whiteCard.frame = CGRectMake(5, 5, 361, 58)
        
        cell.addSubview(whiteCard)
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        var customCell: ReminderTableViewCell = cell as! ReminderTableViewCell
        
        var item: Reminder = currentReminders[indexPath.row]
        
        if (item.isOverdue) { // the current time is later than the to-do item's deadline
            customCell.lblSubtitle.textColor = UIColor.redColor()
        } else {
            customCell.lblSubtitle.textColor = UIColor.blackColor()
        }

    }
    
    func  tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        editReminder = currentReminders[indexPath.row]
        
        self.performSegueWithIdentifier("edit_reminder", sender: self)

    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "edit_reminder"{
            
            var vc: CreateReminderViewController = segue.destinationViewController as! CreateReminderViewController
            
            vc.isNewReminder = false;
            vc.editReminder = self.editReminder
        }
        
    }


}
