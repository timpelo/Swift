//
//  ViewController.swift
//  JussiGame
//
//  Created by developer on 26/10/16.
//  Copyright © 2016 developer. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {
    
    var spriteView : SKView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.spriteView = self.view as? SKView
        
        self.spriteView.showsFPS = true
        self.spriteView.showsNodeCount = true
        self.spriteView.showsDrawCount = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let startScene = StartScene(size: self.spriteView.bounds.size)
        spriteView.presentScene(startScene)
        
        
    }


}

