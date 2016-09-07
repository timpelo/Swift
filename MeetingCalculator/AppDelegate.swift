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
    var updateTimer : NSTimer?
    var locationManager : CLLocationManager?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Creates and starts meeting.
        meeting = MeetingCostModel(numberOfParticipants: 10, averageHourSalary: 35.0, currency: "Euro")
        meeting!.startMeeting()
        
        // Creates location manager, request permission and starts updating location.
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.delegate = self
        locationManager?.startUpdatingLocation()

        return true
    }

    func applicationWillResignActive(application: UIApplication) {

    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Invalidates timer.
        updateTimer?.invalidate()
    }

    func applicationWillEnterForeground(application: UIApplication) {
        
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Creates new timer to track meeting.
        NSLog("Registered timer")
        updateTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(updateMeetingCost), userInfo: nil, repeats: true)
    }

    func applicationWillTerminate(application: UIApplication) {

    }
    
    // MARK: My methods
    func updateMeetingCost() {
        if let meetingTmp : MeetingCostModel? = meeting {
            let cost = meetingTmp!.getCurrentCostOfMeeting
            NSLog("Cost is " + String(cost!))
        }
    }
    
    // MARK: CLLocationManagerDelegate delegate methods
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // Stop updating location.
        locationManager?.stopUpdatingLocation()
        
        // Set coordinates for meeting.
        let location = locations[0].coordinate
        meeting?.latitude = location.latitude
        meeting?.longitude = location.longitude
        
        NSLog("Got location at " + String(location.latitude) + ", " + String(location.longitude))
    }


}

