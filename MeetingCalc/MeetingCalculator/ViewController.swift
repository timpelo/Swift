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
        
        // Create locationmanager.
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.delegate = self
        locationManager?.startUpdatingLocation()
        
        // Create location indicator and set constraints
        locationIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        let topOffset : CGFloat = 5.0
        let endOffset : CGFloat = -20.0
        self.view.addSubview(locationIndicator!)
        let constraitTrail = NSLayoutConstraint(item: locationIndicator!, attribute: .TrailingMargin, relatedBy: .Equal, toItem: startStopButton, attribute: .TrailingMargin, multiplier: 1.0, constant: endOffset)
        let constraitTop = NSLayoutConstraint(item: locationIndicator!, attribute: .TopMargin, relatedBy: .Equal, toItem: meetingNameField, attribute: .TopMargin, multiplier: 1.0, constant: topOffset)
        locationIndicator?.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activateConstraints([constraitTrail, constraitTop])
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
        // Convert text field values to numbers.
        let participantNumber : Int? = Int(meetingMembersField.text!)
        let averageSalary : Double? = Double(averageSalaryField.text!)
        
        // Start meeting if values are valid.
        if(participantNumber != nil && averageSalary != nil) {
            if let meetingSuccess : MeetingCostModel = meeting {
                meetingSuccess.averageHourSalary = averageSalary!
                meetingSuccess.numberOfParticipants = participantNumber!
                meetingSuccess.startMeeting()
                timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(updateMeetingCost), userInfo: nil, repeats: true)
            }
            
            // Changes button text to stop.
            startStopButton.setTitle("Stop meeting", forState: UIControlState.Normal)
            NSLog("Name: " + meetingNameField.text!)
            NSLog("Members: " + meetingMembersField.text!)
            NSLog("Salary: " + averageSalaryField.text!)
        }
        
    }

    @IBAction func meetingButtonPressed(sender: AnyObject) {
        // Do action according if meeting is currently running.
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
        
        // Create CLGeocoder
        geoCoder = CLGeocoder()
        geoCoder?.reverseGeocodeLocation(locations[0], completionHandler: {
            (placemarks, error) in
            let pm = placemarks as? [CLPlacemark]!
            if (pm != nil && pm!.count > 0){
                
                // Get city and country from geocoder and set it as value to meeting name field.
                let location = placemarks![0] as? CLPlacemark
                let meetingCity : String? = location?.locality
                let meetingCountry : String? = location?.country
                let meetingName : String? = "Meeting in " + meetingCity! + ", " + meetingCountry!
                self.meetingNameField.text = meetingName!
                self.locationIndicator!.stopAnimating()
            }
        })
        
        NSLog("Meeting set to " + String(meeting?.latitude) + ", " + String(meeting?.longitude))
    }
}

