//
//  PointModel.swift
//  Jobs
//
//  Created by developer on 21/09/16.
//  Copyright © 2016 developer. All rights reserved.
//

import Foundation
import UIKit

class PointModel{
    var x : CGFloat
    var y: CGFloat
    
    init (x x_ : CGFloat, y y_ : CGFloat) {
        self.x = x_
        self.y = y_
    }
    
    var location : CGPoint {
        
        get{
            return CGPoint(x: x, y: y)
        }
        set(newPoint){
            self.x = newPoint.x
            self.y = newPoint.y
        }
    }
}