//
//  MeetingCostModel.swift
//  MeetingCalculator
//
//  Created by developer on 07/09/16.
//  Copyright © 2016 developer. All rights reserved.
//

import Foundation

class MeetingCostModel {
    var averageHourSalary : Double
    var isMeetingOn : Bool = false
    var numberOfParticipants : Int
    var latitude : Double?
    var longitude : Double?
    var startMeetingDate : NSDate?
    var currency : String?
    
    init(numberOfParticipants : Int, averageHourSalary : Double, currency : String) {
        self.numberOfParticipants = numberOfParticipants;
        self.averageHourSalary = averageHourSalary
        self.currency = currency
    }
    
    // initializes startMeetingDate if meeting was off
    func startMeeting() {
        NSLog("Meeting started")
        if(!isMeetingOn) {
            startMeetingDate = NSDate()
            isMeetingOn = true
        }
    }
    
    // returns the current cost of meeting using startMeetingDate, averageHourSalary
    // and numberOfParticipants
    var getCurrentCostOfMeeting : Double? {
        get {
            if(isMeetingOn) {
                let checkpoint = NSDate()
                let averageSecondSalary = averageHourSalary / 60 / 60
                let difference = checkpoint.timeIntervalSinceDate(startMeetingDate!)
                return (difference * averageSecondSalary) * Double(numberOfParticipants)
            }
            return nil
        }
    }
    
    // sets isMeetingOn to false
    func endMeeting() {
        isMeetingOn = false
    }
}
