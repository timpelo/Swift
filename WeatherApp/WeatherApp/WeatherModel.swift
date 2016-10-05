//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by developer on 05/10/16.
//  Copyright © 2016 developer. All rights reserved.
//
import UIKit
class WeatherModel {
    var items : [WeatherItem] = []
    var city : String = "N/A"
    
    func addItem(item : WeatherItem) {
        items.append(item)
    }
    
    // Class for holding one item.
    internal class WeatherItem {
        var icon : String
        var temp : Double
        var date : NSDate
        
        init (icon : String, temperature : Double, date : NSDate) {
            self.icon = icon
            self.temp = temperature
            self.date = date
            
        }
        
        var celcius : Double {
            get {
                let celcius = temp - 273.15
                return Double(round(100*celcius)/100)
            }
        }
        
    }
}
