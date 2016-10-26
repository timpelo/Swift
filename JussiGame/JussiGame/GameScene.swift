//
//  GameScene.swift
//  JussiGame
//
//  Created by developer on 26/10/16.
//  Copyright © 2016 developer. All rights reserved.
//

import Foundation
import SpriteKit

class GameScene : SKScene {
    
    var alien : SKSpriteNode!
    
    override func didMove(to view: SKView) {
        self.backgroundColor = SKColor.white
        self.addChild(createAlien())
        self.addChild(createButton())
        
        let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody = borderBody
        
    }
    
    func createAlien() -> SKSpriteNode {
        alien = SKSpriteNode(imageNamed: "alien")
        alien.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        alien.setScale(0.05)
        alien.physicsBody = SKPhysicsBody(texture: alien.texture!, size: alien.size)
        alien.physicsBody!.mass = 0.2
        alien.physicsBody!.restitution = 0.5
        alien.physicsBody!.friction = 0.5
        
        return alien
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let location = touch?.location(in: self)
        let node = self.atPoint(location!)
        
        if(node.name == "fireButton") {
            fireBall()
        } else {
            jump()
        }
    }
    
    func jump() -> Void{
        self.alien.physicsBody!.applyImpulse(CGVector(dx: 0, dy: 70))
    }
    
    func createButton() -> SKSpriteNode {
        let button = SKSpriteNode(imageNamed: "button")
        button.setScale(0.3)
        button.position = CGPoint(x: self.frame.width - button.frame.width/2,
                                  y: button.frame.height/2)
        
        button.name = "fireButton"
        
        return button
    }
    func fireBall() -> Void {
        let ball = SKSpriteNode(imageNamed: "ball")
        ball.setScale(0.5)
        ball.position.y = self.alien.position.y +
            (alien.frame.height / 2) +
            (ball.frame.height / 2 + 10)
        ball.position.x = self.alien.position.x
        ball.physicsBody = SKPhysicsBody(texture: ball.texture!, size: ball.size)
        ball.physicsBody!.mass = 0.1
        ball.physicsBody!.friction = 0.5
        ball.physicsBody!.restitution = 0.8
        
        self.insertChild(ball, at: 1)
        ball.physicsBody!.applyImpulse(CGVector(dx: 0, dy: 60))
        
    }
}
