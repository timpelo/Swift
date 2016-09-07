//
//  AppDelegate.swift
//  MeetingCalculator
//
//  Created by developer on 07/09/16.
//  Copyright © 2016 developer. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var meeting : MeetingCostModel?
    var updateTimer : NSTimer?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        meeting = MeetingCostModel(numberOfParticipants: 10, averageHourSalary: 35.0, currency: "Euro")
        meeting!.startMeeting()
        
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {

        // Invalidates the timer.
        updateTimer?.invalidate()
        
    }

    func applicationWillEnterForeground(application: UIApplication) {
        
    }

    func applicationDidBecomeActive(application: UIApplication) {
        
        // Creates the timer.
        NSLog("Registered timer")
        updateTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(updateMeetingCost), userInfo: nil, repeats: true)
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func updateMeetingCost() {
        NSLog("Updating...")
        if let meetingTmp : MeetingCostModel? = meeting {
            let cost = meetingTmp!.getCurrentCostOfMeeting
            NSLog("Cost is " + String(cost!))
        }
    }


}

