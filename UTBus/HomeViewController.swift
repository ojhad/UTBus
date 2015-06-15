//
//  HomeViewController.swift
//  UTBus
//
//  Created by Dilip Ojha on 2015-06-15.
//  Copyright (c) 2015 madlab. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    var dataModel: ScheduleDataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let bundle = NSBundle.mainBundle()
        let URL: NSURL? = bundle.URLForResource("data", withExtension: ".json");
        let data: NSData? = NSData(contentsOfURL: URL!)
        
        dataModel = ScheduleDataModel(data: data ?? NSData())
        
        
        
        
//        var parseError: NSError?
//        let parsedObject: AnyObject? = NSJSONSerialization.JSONObjectWithData(data!,
//            options: NSJSONReadingOptions.AllowFragments,
//            error:&parseError)
//        
//        //println("Printing Time: \(parsedObject)")
//        
//        if let route = parsedObject as? NSDictionary {
//            println("Success Route\n")
//            if let day = route["monday"] as? NSArray {
//                println("Success day\n")
//                if let time = day[0] as? NSDictionary{
//                    println("Success time\n")
//                    if let timeVal = time["time"] as? NSString{
//                        println("First Time: \(time)")
//                    }
//                }
//            }
//        }
        
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
