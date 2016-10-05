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
    @IBOutlet weak var locationInfoLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        weatherIcon.alpha = 0
        cityLabel.alpha = 0
        temperatureLabel.alpha = 0
        activityIndicator.startAnimating()
        
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
        
        // Update info of weather elements
        let today = weather?.items[0]
        cityLabel.text = weather?.city
        temperatureLabel.text = String(today!.celcius) + " °C"
        let imageURL = "http://openweathermap.org/img/w/\(today!.icon).png"
        let imageData = NSData(contentsOfURL: NSURL(string: imageURL)!);
        weatherIcon.image = UIImage(data: imageData!)
        
        // Hide indicator elements
        activityIndicator.stopAnimating()
        activityIndicator.hidden = true
        locationInfoLabel.hidden = true
        
        // Fade in weather elements.
        UIView.animateWithDuration(1.5, animations: {
            self.weatherIcon.alpha = 1.0
            self.cityLabel.alpha = 1.0
            self.temperatureLabel.alpha = 1.0
        })
    }
}

