//
//  SettingsViewController.swift
//  Jobs
//
//  Created by developer on 21/09/16.
//  Copyright © 2016 developer. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var xField: UITextField!
    @IBOutlet weak var yField: UITextField!
    var jobsLocation : PointModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Settings"
        self.edgesForExtendedLayout = UIRectEdge.None
        xField.text = String(jobsLocation!.x)
        yField.text = String(jobsLocation!.y)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        if let xFloat : Float = NSNumberFormatter().numberFromString(xField.text!)!.floatValue {
            jobsLocation!.x = CGFloat(xFloat)
        }
        
        if let yFloat : Float = NSNumberFormatter().numberFromString(yField.text!)!.floatValue {
            jobsLocation!.y = CGFloat(yFloat)
        }
    }  
}

