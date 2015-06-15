//
//  HomeViewController.swift
//  UTBus
//
//  Created by Dilip Ojha on 2015-06-15.
//  Copyright (c) 2015 madlab. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

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
        
        let argument: String = "monday"
        
        let days: NSArray = source.getArrayOfTimesForDay(argument)
        
        println("\(days)")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
