//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by developer on 05/10/16.
//  Copyright © 2016 developer. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let appId = "b5c37673c9f4331c72f5b9671325156b";
    let baseUrl = "http://api.openweathermap.org/data/2.5/weather?appId=";
    var longitude : Double? = 139
    let latitude : Double? = 35
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        let session = NSURLSession.sharedSession()
        NSLog("created session")
        let task = session.dataTaskWithURL(buildRequestUrl()) { data, response, error in
            if error != nil {
                NSLog(error!.localizedDescription)
            } else {
                var jsonData = self.parseData(data!)
            }
        }
        
        task.resume()
        
        
        return true
    }
    
    func parseData(data : NSData) -> NSDictionary? {
        var json : NSDictionary?
        
        do {
            json =
                try NSJSONSerialization.JSONObjectWithData(
                    data,
                    options:NSJSONReadingOptions.MutableContainers) as! NSDictionary
            return json
        }
        catch {
            return nil
        }
    }
    
    func buildRequestUrl() -> NSURL {
        let urlString = baseUrl + appId + "&lat=" + String(latitude!) + "&lon=" + String(longitude!);
        let url = NSURL(string: urlString)
        NSLog("requesting: " + urlString)
        return url!
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

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

