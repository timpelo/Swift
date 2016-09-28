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
        let meetingPrefs : MeetingCostModel? = AppDelegate.restoreDataModel()
        if(meetingPrefs != nil) {
            self.meeting = meetingPrefs
        }
        
    }

    func applicationWillTerminate(application: UIApplication) {
        
        // Store if meeting was on
        if let meetingPrefs : MeetingCostModel? = meeting! as MeetingCostModel {
            AppDelegate.archiveDataModel(meetingPrefs!)
        }
        
    }
    
    class func archiveDataModel(meetingModel: MeetingCostModel) {
        let defaultPropertyFile = NSUserDefaults.standardUserDefaults()
        let data = NSKeyedArchiver.archivedDataWithRootObject(meetingModel)
        
        defaultPropertyFile.setObject(data, forKey: "meeting")
        defaultPropertyFile.synchronize()
    }
    
    class func restoreDataModel() -> MeetingCostModel? {
        let defaultPropertyFile = NSUserDefaults.standardUserDefaults()
        let meetingData = defaultPropertyFile.objectForKey("meeting") as! NSData?
        
        if(meetingData != nil) {
            let meeting = NSKeyedUnarchiver.unarchiveObjectWithData(meetingData!) as! MeetingCostModel?
            return meeting
        } else {
            return nil
        }
    }
    
    


}

