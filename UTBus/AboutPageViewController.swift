//
//  AboutPageViewController.swift
//  UTBus
//
//  Created by Dilip Ojha on 2015-07-13.
//  Copyright (c) 2015 madlab. All rights reserved.
//

import UIKit

class AboutPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func tappedGoToMADLabWeb(sender: AnyObject) {
        
        if let url = NSURL(string: "http://mobile.utoronto.ca/madlab") {
            UIApplication.sharedApplication().openURL(url)
        }
    }

    @IBAction func tappedGoToIcons8Website(sender: AnyObject) {
        
        if let url = NSURL(string: "https://icons8.com/") {
            UIApplication.sharedApplication().openURL(url)
        }
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
