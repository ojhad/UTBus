//
//  AppDelegate.swift
//  UTBus
//
//  Created by Dilip Ojha on 2015-06-15.
//  Copyright (c) 2015 madlab. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var locationManager: CLLocationManager?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        var navBarAppearance = UINavigationBar.appearance()
        
        navBarAppearance.tintColor = UIColor.whiteColor()
        navBarAppearance.barTintColor = UIColor(red:0.0, green:0.18, blue:0.4, alpha:1.0)
        
        navBarAppearance.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        
        UIApplication.sharedApplication().statusBarStyle = .LightContent

        
        UITabBar.appearance().tintColor = UIColor(red:0.0, green:0.18, blue:0.4, alpha:1.0)
        UISegmentedControl.appearance().tintColor = UIColor(red:0.0, green:0.18, blue:0.4, alpha:1.0)
        
        application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes: .Alert | .Badge | .Sound, categories: nil))
        
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
        
        
        return true
    }
    
    func application(application: UIApplication,
        handleWatchKitExtensionRequest userInfo: [NSObject : AnyObject]?,
        reply: (([NSObject : AnyObject]!) -> Void)!) {
            if let userInfo = userInfo, request = userInfo["request"] as? String {
                if request == "UTSG" {
                    
                    let temp=Parser.getArrayOfTimesForDay("St.George Route", location: "Hart House", day: Parser.getDay())
                    let times=Parser.getFuture(temp!)
        
                    reply(["UTSG": NSKeyedArchiver.archivedDataWithRootObject(times)])
                    
                    return
                }
                else if request == "UTM"{
                    let temp=Parser.getArrayOfTimesForDay("Sheridan Route", location: "Deerfield Hall North", day: Parser.getDay())
                    let times=Parser.getFuture(temp!)
                    
                    reply(["UTM": NSKeyedArchiver.archivedDataWithRootObject(times)])
                    
                    return
                }
                else{
                    let temp=Parser.getArrayOfTimesForDay("Sheridan Route", location: "Sheridan", day: Parser.getDay())
                    let times=Parser.getFuture(temp!)
                    
                    reply(["Sheridan": NSKeyedArchiver.archivedDataWithRootObject(times)])
                    
                    return
                }
            }
            
            reply([:])
    }
    
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        NSNotificationCenter.defaultCenter().postNotificationName("ReminderListShouldRefresh", object: self)
    }
    
    func applicationDidBecomeActive(application: UIApplication){
        NSNotificationCenter.defaultCenter().postNotificationName("ReminderListShouldRefresh", object: self)
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

