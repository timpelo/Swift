//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by developer on 05/10/16.
//  Copyright © 2016 developer. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {
    
    let appId = "b5c37673c9f4331c72f5b9671325156b";
    let baseUrl = "http://api.openweathermap.org/data/2.5/weather?appId=";
    var longitude : Double? = 139
    var latitude : Double? = 35
    var window: UIWindow?
    var todayViewController : ViewController?
    var forecastViewController : ForecastViewController?
    var weather : WeatherModel?
    var locationManager : CLLocationManager?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Load view controllers.
        var controllers = (self.window!.rootViewController as! UITabBarController).viewControllers
        self.todayViewController = controllers?[0] as? ViewController
        self.forecastViewController = controllers?[1] as? ForecastViewController
        
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.delegate = self
        locationManager?.startUpdatingLocation()
        
        return true
    }
    
    func updateWeatherData() {
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(buildRequestUrl()) { data, response, error in
            if error != nil {
                NSLog(error!.localizedDescription)
            } else {
                let jsonData = self.convertToJson(data!)
                self.weather = self.parseWeatherData(jsonData!)
                self.forecastViewController?.weather = self.weather
                self.todayViewController?.weather = self.weather
                
                self.todayViewController?.update()
                
            }
        }
        
        task.resume()
    }
    
    func convertToJson(data : NSData) -> NSDictionary? {
        var json : NSDictionary?
        do {
            json =
                try NSJSONSerialization.JSONObjectWithData(
                    data,
                    options:NSJSONReadingOptions.MutableContainers) as? NSDictionary
            return json
        }
        catch {
            return nil
        }
    }
    
    func parseWeatherData(data : NSDictionary) -> WeatherModel {
        let weatherModel = WeatherModel()
        
        let main = data["main"] as? NSDictionary
        let weatherArray = data["weather"] as? NSArray
        let weather = weatherArray![0] as? NSDictionary
        let temp = (main!["temp"]) as? Double
        let icon = (weather!["icon"]) as? String
        let timeInterval = data["dt"] as? NSTimeInterval
        let date = NSDate(timeIntervalSince1970: timeInterval!)
        let city = data["name"] as? String
        
        NSLog(String(temp))
        NSLog(String(icon))
        NSLog(String(date))
        NSLog(String(city))
        
        let item = WeatherModel.WeatherItem(icon: icon!, temperature: temp!, date: date)
        weatherModel.addItem(item)
        weatherModel.city = city!
        
        return weatherModel
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
    
    // MARK: CLLocationManagerDelegate delegate methods
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // Stop updating location.
        locationManager?.stopUpdatingLocation()
        
        // Set coordinates for location.
        let location = locations[0].coordinate
        self.latitude = location.latitude
        self.longitude = location.longitude
        
        self.updateWeatherData()
    }



}

