//
//  StartScene.swift
//  JussiGame
//
//  Created by developer on 26/10/16.
//  Copyright © 2016 developer. All rights reserved.
//

import Foundation
import SpriteKit

class StartScene : SKScene {
    let TITLE = "Game Title"
    
    override func didMove(to view: SKView) {
        self.backgroundColor = SKColor.blue
        self.addChild(self.createTitle())
    }
    
    func createTitle() -> SKLabelNode {
        let helloNode = SKLabelNode(fontNamed: "Chalkduster")
        
        helloNode.name = self.TITLE
        helloNode.text = self.TITLE
        helloNode.fontSize = 50
        helloNode.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        
        return helloNode;
    }
}
