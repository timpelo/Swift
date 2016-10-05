//
//  ViewController.swift
//  WeatherApp
//
//  Created by developer on 05/10/16.
//  Copyright © 2016 developer. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    var weather : WeatherModel?
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        weatherIcon.alpha = 0
        cityLabel.alpha = 0
        temperatureLabel.alpha = 0
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func update() {
        dispatch_async(dispatch_get_main_queue()) {
            self.updateWeatherToView()
        }
    }
    
    func updateWeatherToView() {
        let today = weather?.items[0]
        cityLabel.text = weather?.city
        temperatureLabel.text = String(today!.celcius)
        let imageURL = "http://openweathermap.org/img/w/\(today!.icon).png"
        let imageData = NSData(contentsOfURL: NSURL(string: imageURL)!);
        weatherIcon.image = UIImage(data: imageData!)
        
        UIView.animateWithDuration(1.5, animations: {
            self.weatherIcon.alpha = 1.0
            self.cityLabel.alpha = 1.0
            self.temperatureLabel.alpha = 1.0
        })
    }
}

