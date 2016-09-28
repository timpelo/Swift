//
//  ViewController.swift
//  ReservationApp
//
//  Created by developer on 28/09/16.
//  Copyright © 2016 developer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchTerm: UITextField!
    var dataService : OpenDataService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataService = OpenDataService()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func executeSearch(sender: AnyObject) {
        dataService?.queryReservations(searchTerm.text!)
    }

}

