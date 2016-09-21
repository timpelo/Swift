//
//  AppDelegate.swift
//  MeetingCalculator
//
//  Created by developer on 07/09/16.
//  Copyright © 2016 developer. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    var window: UIWindow?
    var meeting : MeetingCostModel?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // Creates empty meeting and sets it to view controller
        meeting = MeetingCostModel(numberOfParticipants: 0, averageHourSalary: 0, currency: "€")
        
        // Let's fetch the UINavigationController
        let naviViewController = window?.rootViewController as! UINavigationController
        
        // It may have several viewControllers, let's take the first and cast it to ViewController
        let firstViewController  = naviViewController.viewControllers[0] as! ViewController
        
        // Let's add the meeting model
        firstViewController.meeting = self.meeting

        return true
    }

    func applicationWillResignActive(application: UIApplication) {

    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Invalidates timer.
        
    }

    func applicationWillEnterForeground(application: UIApplication) {
        
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Creates new timer to track meeting.
    }

    func applicationWillTerminate(application: UIApplication) {

    }
    
    


}

