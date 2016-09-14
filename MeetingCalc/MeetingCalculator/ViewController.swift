//
//  ViewController.swift
//  MeetingCalculator
//
//  Created by developer on 07/09/16.
//  Copyright © 2016 developer. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {


    @IBOutlet weak var meetingNameField: UITextField!
    @IBOutlet weak var meetingMembersField: UITextField!
    @IBOutlet weak var averageSalaryField: UITextField!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var startStopButton: UIButton!
    
    var meeting : MeetingCostModel?
    var timer : NSTimer?
    var locationManager : CLLocationManager?
    var geoCoder : CLGeocoder?
    var locationIndicator : UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Sets location manager.
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.delegate = self
        locationManager?.startUpdatingLocation()
        locationIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        NSLayoutConstraint(item: locationIndicator!, attribute: .Leading, relatedBy: .Equal, toItem: meetingNameField, attribute: .LeadingMargin, multiplier: 1.0, constant: 0.0).active = true
        meetingNameField.addSubview(locationIndicator!)
        locationIndicator?.startAnimating()
        locationIndicator?.hidesWhenStopped = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateMeetingCost() {
        var cost : Double = (meeting?.getCurrentCostOfMeeting)!
        cost = (round(cost*100))/100
        costLabel.text = String(cost) + (meeting?.currency)!
    }
    
    func stopMeeting() {
        // Invalidates timer and updates button text.
        timer?.invalidate()
        meeting?.isMeetingOn = false;
        startStopButton.setTitle("Start meeting", forState: UIControlState.Normal)
    }
    
    func startMeeting() {
        let participantNumber : Int? = Int(meetingMembersField.text!)
        let averageSalary : Double? = Double(averageSalaryField.text!)
        
        if(participantNumber != nil && averageSalary != nil) {
            // If meeting wasn't on, update details.
            if let meetingSuccess : MeetingCostModel = meeting {
                meetingSuccess.averageHourSalary = averageSalary!
                meetingSuccess.numberOfParticipants = participantNumber!
                meetingSuccess.startMeeting()
                timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(updateMeetingCost), userInfo: nil, repeats: true)
            }
            
            // Changes button text to stop.
            startStopButton.setTitle("Stop meeting", forState: UIControlState.Normal)
            NSLog("Meeting starts")
            NSLog("Name: " + meetingNameField.text!)
            NSLog("Members: " + meetingMembersField.text!)
            NSLog("Salary: " + averageSalaryField.text!)
            
        }
        
    }

    @IBAction func meetingButtonPressed(sender: AnyObject) {
        if((meeting?.isMeetingOn)!){
            stopMeeting()
        } else {
            startMeeting()
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
        
        geoCoder = CLGeocoder()
        geoCoder?.reverseGeocodeLocation(locations[0], completionHandler: {
            (placemarks, error) in
            let pm = placemarks as? [CLPlacemark]!
            if (pm != nil && pm!.count > 0){
                let location = placemarks![0] as? CLPlacemark
                
                let meetingCity : String? = location?.locality
                let meetingCountry : String? = location?.country
                let meetingName : String? = "Meeting in " + meetingCity! + ", " + meetingCountry!
                self.meetingNameField.text = meetingName!
                //self.locationIndicator!.stopAnimating()
            }
        })
        
        NSLog("Meeting set to " + String(meeting?.latitude) + ", " + String(meeting?.longitude))
    }
}

