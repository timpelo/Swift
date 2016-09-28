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
        
        let meeting = AppDelegate.restoreDataModel()
        if(meeting != nil) {
            self.meeting = meeting
        }
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
