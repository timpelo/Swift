//
//  OpenDataService.swift
//  ReservationApp
//
//  Created by developer on 28/09/16.
//  Copyright © 2016 developer. All rights reserved.
//

import Foundation

class OpenDataService {
    
    let apiKey : String = "3yi2ctWO4w0GvyXvGvzY"
    let baseUrl : String = "https://opendata.tamk.fi/r1/reservation/search?"
    
    init() {
    
    }
    
    func queryReservations(className : String) -> String? {
        var responseForReturn : String?
        
        // Create start and end dates.
        let calendar: NSCalendar! = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let now: NSDate! = NSDate()
        let startTime = calendar.dateBySettingHour(8, minute: 0, second: 0, ofDate: now, options: NSCalendarOptions.MatchFirst)!
        let endTime = calendar.dateBySettingHour(18, minute: 0, second: 0, ofDate: now, options: NSCalendarOptions.MatchFirst)!
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-mm-DD'T'hh:MM"
 
        
        // Build request
        let request = NSMutableURLRequest(URL: NSURL(string: baseUrl)!)
        request.HTTPMethod = "POST"
        let postString = "{apiKey:" + self.apiKey + ",startDate:" + formatter.stringFromDate(startTime) + ",endDate:" + formatter.stringFromDate(endTime) + ",room:[" + className + "]}ß"
        
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            let responseString = String(data: data!, encoding: NSUTF8StringEncoding)
            print("responseString = \(responseString)")
            responseForReturn = responseString
        }
        task.resume()
        
        return responseForReturn
        
    }
}
