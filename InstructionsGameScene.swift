//
//  InstructionsGameScene.swift
//  Ball Bouncer
//
//  Created by Cameron Byers on 7/9/16.
//  Copyright © 2016 Cameron Byers. All rights reserved.
//

import SpriteKit
import AVFoundation
import UIKit

class InstructionsGameScene: SKScene {
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let background = SKSpriteNode(imageNamed: "Instructions")
        background.position = CGPointMake(frame.midX, frame.midY)
        background.size = CGSizeMake(frame.width, frame.height)
        addChild(background)

    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        let transition = SKTransition.revealWithDirection(.Up, duration: 1.0)
        
        let nextScene = HomeScreenGameScene(size: self.scene!.size)
        nextScene.scaleMode = .AspectFill
        
        self.scene?.view?.presentScene(nextScene, transition: transition)

    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
    }
    
}
