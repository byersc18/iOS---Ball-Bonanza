//
//  Square.swift
//  Ball Bouncer
//
//  Created by Cameron Byers on 6/30/16.
//  Copyright © 2016 Cameron Byers. All rights reserved.
//

import Foundation
import SpriteKit

class Square: SKShapeNode {
    
    var square: SKSpriteNode!
    var x: CGFloat!
    var y: CGFloat!
    var xSpeed: CGFloat!
    var ySpeed: CGFloat!
    
    init(sideLength: CGFloat, xPos: CGFloat, yPos: CGFloat, xS: CGFloat, yS: CGFloat) {
        super.init()
        x = xPos
        y = yPos
        xSpeed = xS
        ySpeed = yS
        square = SKSpriteNode(imageNamed: "square")
        square.size = CGSizeMake(sideLength * 1.17, sideLength * 1.17)
        square.position = CGPointMake(xPos, yPos)
        square.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(sideLength, sideLength))
        square.physicsBody?.affectedByGravity = false
        square.physicsBody?.categoryBitMask = PhysicsCategory.square
        square.physicsBody?.collisionBitMask = PhysicsCategory.border
        square.physicsBody?.contactTestBitMask = PhysicsCategory.ball
        addChild(square)
    }
    
    func constantMovement() {
        x = x + xSpeed
        y = y + ySpeed
        
        square.position.x = square.position.x + xSpeed
        square.position.y = square.position.y + ySpeed
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
