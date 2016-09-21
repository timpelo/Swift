//
//  JobsViewController.swift
//  Jobs
//
//  Created by developer on 21/09/16.
//  Copyright © 2016 developer. All rights reserved.
//

import UIKit

class JobsViewController: UIViewController {
    
    var settingsView : SettingsViewController?
    var jobsLocation : PointModel?
    
    @IBOutlet weak var jobsView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Steve Jobs"
        self.edgesForExtendedLayout = UIRectEdge.None
    }
    
    override func viewDidLayoutSubviews() {
        NSLog("Appeared")
        if let location : PointModel = jobsLocation {
            jobsView.frame.origin = location.location
            NSLog("location " + String(jobsView.center))
        } else {
            jobsView.frame.origin.x = UIScreen.mainScreen().bounds.width/2
            jobsView.frame.origin.y = UIScreen.mainScreen().bounds.height/2
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goToSettings(sender: AnyObject) {
        
        // Gets location of Jobs and set it to PointModel and SettingsView
        let jobsFrame = jobsView.frame
        jobsLocation = PointModel(x: jobsFrame.origin.x, y: jobsFrame.origin.y)
        settingsView = SettingsViewController(nibName: "SettingsView", bundle: nil)
        settingsView?.jobsLocation = self.jobsLocation
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.navigation?.pushViewController(settingsView!, animated: true)
        
    }
    
}
