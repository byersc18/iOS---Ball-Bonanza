//
//  Ball.swift
//  Ball Bouncer
//
//  Created by Cameron Byers on 6/30/16.
//  Copyright © 2016 Cameron Byers. All rights reserved.
//

import Foundation
import SpriteKit

class Ball: SKShapeNode {
    
    var ball: SKSpriteNode!
    var xSpeed: CGFloat!
    var ySpeed: CGFloat!
    var x: CGFloat!
    var y: CGFloat!
    
    init(radius: CGFloat, xPos: CGFloat, yPos: CGFloat, xS: CGFloat, yS: CGFloat, physics: Bool) {
        super.init()
        xSpeed = xS
        ySpeed = yS
        x = xPos
        y = yPos
        ball = SKSpriteNode(imageNamed: "blue")
        ball.size = CGSizeMake(radius * 2.45, radius * 2.45)
        ball.position = CGPointMake(xPos, yPos)
        if physics == true {
            ball.physicsBody = SKPhysicsBody(circleOfRadius: radius)
            ball.physicsBody?.affectedByGravity = false
            ball.physicsBody?.categoryBitMask = PhysicsCategory.ball
            ball.physicsBody?.contactTestBitMask = PhysicsCategory.square | PhysicsCategory.border
        }
        addChild(ball)
    }
    
    func directionMovement(speedMultiplier: Double, angleX: Double, angleY: Double) {

        let moveX = angleX * speedMultiplier
        let moveY = angleY * speedMultiplier
        
        x = x + CGFloat(moveX)
        y = y + CGFloat(moveY)
        
        ball.position.x = ball.position.x + CGFloat(moveX)
        ball.position.y = ball.position.y + CGFloat(moveY)
    }
    
    func constantMovement() {
        x = x + xSpeed
        y = y + ySpeed
        
        ball.position.x = ball.position.x + xSpeed
        ball.position.y = ball.position.y + ySpeed
    }
    
    func changeColor() {
        let random = Int(arc4random_uniform(6) + 1)
        
        if random == 1 {
            ball.texture = SKTexture(imageNamed: "aqua")
        }
        else if random == 2 {
            ball.texture = SKTexture(imageNamed: "blue")
        }
        else if random == 3 {
            ball.texture = SKTexture(imageNamed: "green")
        }
        else if random == 4 {
            ball.texture = SKTexture(imageNamed: "pink")
        }
        else if random == 5 {
            ball.texture = SKTexture(imageNamed: "red")
        }
        else {
            ball.texture = SKTexture(imageNamed: "yellow")
        }
    }
    
    func stop() {
        xSpeed = 0
        ySpeed = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
