//
//  HomeViewController.swift
//  UTBus
//
//  Created by Dilip Ojha on 2015-06-15.
//  Copyright (c) 2015 madlab. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let textCellIdentifier = "TextCell"
    
    var swiftBlogs = ["Ray Wenderlich", "NSHipster", "iOS Developer Tips", "Jameson Quave", "Natasha The Robot", "Coding Explorer", "That Thing In Swift", "Andrew Bancroft", "iAchieved.it", "Airspeed Velocity"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        /*
        let bundle = NSBundle.mainBundle()
        let URL: NSURL? = bundle.URLForResource("data", withExtension: ".json");
        let data: NSData? = NSData(contentsOfURL: URL!)

        var parseError: NSError?
        let parsedObject: AnyObject? = NSJSONSerialization.JSONObjectWithData(data!,
            options: NSJSONReadingOptions.AllowFragments,
            error:&parseError)
        
        //println("Printing Time: \(parsedObject)")
        
        if let main = parsedObject as? NSDictionary {
            println("Success Route\n")
            if let route = main["mississauga"] as? NSDictionary {
                println("Success day\n")
                if let day = route["monday"] as? NSArray{
                    println("Success time\n")
                    if let time = day[22] as? NSDictionary{
                        println("Success time2\n")
                        if let timeVal = time["time"] as? NSString{
                            println("First Time: \(time)")
                        }
                    }
                }
            }
        }*/
        
        let source: dataParser = dataParser.new()
        
        let days: NSArray = source.getArrayOfTimesForDay("monday")
        
        //let time: String = days[0] as! String
        
        let time1: NSDictionary? = days[0] as? NSDictionary
        
        
        println("\(time1)")
        
        let time = time1["time"]
        
        //swiftBlogs.append(time)
        
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    // MARK:  UITextFieldDelegate Methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return swiftBlogs.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as! UITableViewCell
        
        let row = indexPath.row
        cell.textLabel?.text = swiftBlogs[row] as? String
        
        return cell
    }
    
    // MARK:  UITableViewDelegate Methods
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
        println(swiftBlogs[row])
    }
}
