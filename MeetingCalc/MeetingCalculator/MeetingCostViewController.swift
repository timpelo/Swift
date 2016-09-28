//
//  MeetingCostViewController.swift
//  MeetingCalculator
//
//  Created by developer on 21/09/16.
//  Copyright © 2016 developer. All rights reserved.
//

import UIKit

class MeetingCostViewController : UIViewController, UIAlertViewDelegate {
    var meeting : MeetingCostModel?
    var timer : NSTimer?
    @IBOutlet weak var costLabel: UILabel!
    
    override func viewDidLoad() {
        self.title = "Meeting Cost"
        self.edgesForExtendedLayout = UIRectEdge.Left
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(updateMeetingCost), userInfo: nil, repeats: true)
    }
    
    func updateMeetingCost() {
        var cost : Double? = meeting?.getCurrentCostOfMeeting
        
        if(cost != nil) {
            cost = (round(cost!*100))/100
            costLabel.text = String(cost!) + (meeting?.currency)!
            NSLog(String(cost))
        } else {
            NSLog("nil")
        }
    }
    
    override func encodeRestorableStateWithCoder(coder: NSCoder) {
        coder.encodeObject(self.costLabel.text, forKey:"costLabel")
        AppDelegate.archiveDataModel(meeting!)
        super.encodeRestorableStateWithCoder(coder)
    }
    
    override func decodeRestorableStateWithCoder(coder: NSCoder) {
        let cost = coder.decodeObjectForKey("costLabel") as? String
        
        if(cost != nil) {
            self.costLabel.text = cost
        }
        
        let meeting = AppDelegate.restoreDataModel()
        if(meeting != nil && meeting?.getCurrentCostOfMeeting != nil) {
            self.meeting = meeting
            meeting?.startMeeting()
            NSLog("Meeting found")
            NSLog(String(meeting?.averageHourSalary))
            NSLog(String(meeting?.numberOfParticipants))
            NSLog(String(meeting?.currency))
        } else{
            NSLog("No meeting found")
        }
        
        super.decodeRestorableStateWithCoder(coder);
    }

    
    func stopMeeting() {
        // Invalidates timer and updates button text.
        timer?.invalidate()
        meeting?.isMeetingOn = false;
    }
    
    
    override func viewDidAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @IBAction func showNavBar(sender: AnyObject) {
        let alert = UIAlertView(title: "Stop the meeting?", message: "", delegate: self, cancelButtonTitle: "Continue meeting", otherButtonTitles: "End meeting")
        alert.show()
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        
        if(buttonIndex == 1) {
            stopMeeting()
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
}
