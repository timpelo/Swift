//
//  ViewController.swift
//  MeetingCalculator
//
//  Created by developer on 07/09/16.
//  Copyright © 2016 developer. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, UIAlertViewDelegate {


    @IBOutlet weak var meetingNameField: UITextField!
    @IBOutlet weak var meetingMembersField: UITextField!
    @IBOutlet weak var averageSalaryField: UITextField!
    @IBOutlet weak var startStopButton: UIButton!
    
    var meeting : MeetingCostModel?
    var timer : NSTimer?
    var locationManager : CLLocationManager?
    var geoCoder : CLGeocoder?
    var locationIndicator : UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge.Left
        
        // Create locationmanager.
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.delegate = self
        locationManager?.startUpdatingLocation()
        
        // Create location indicator and set constraints
        locationIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        meetingNameField.rightView = locationIndicator
        locationIndicator?.startAnimating()
        locationIndicator?.hidesWhenStopped = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destination = segue.destinationViewController as! MeetingCostViewController
        destination.meeting = self.meeting
        destination.timer = self.timer
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        let members : Int? = Int(meetingMembersField.text!)
        let salary : Double? = Double(averageSalaryField.text!)
        
        if(members != nil && salary != nil) {
            startMeeting()
            return true
        } else {
            UIAlertView(title: "Error", message: "Invalid values in members or average salary", delegate: self, cancelButtonTitle: "Ok").show()
            return false
        }
    }
    
    override func encodeRestorableStateWithCoder(coder: NSCoder) {
        coder.encodeObject(self.meetingNameField.text, forKey:"meetingField")
        coder.encodeObject(self.meetingMembersField.text, forKey:"memberField")
        coder.encodeObject(self.averageSalaryField.text, forKey:"salaryField")
        super.encodeRestorableStateWithCoder(coder)
    }
    override func decodeRestorableStateWithCoder(coder: NSCoder) {
        let nameText = coder.decodeObjectForKey("meetingField") as? String
        let memberText = coder.decodeObjectForKey("memberField") as? String
        let salaryText = coder.decodeObjectForKey("salaryField") as? String
        
        if(nameText != nil) {
            self.meetingNameField.text = nameText
        }
        
        if(memberText != nil) {
            self.meetingMembersField.text = memberText
        }
        
        if(salaryText != nil) {
            self.averageSalaryField.text = salaryText
        }
        super.decodeRestorableStateWithCoder(coder);
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
                
                AppDelegate.archiveDataModel(meetingSuccess)
            }
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

