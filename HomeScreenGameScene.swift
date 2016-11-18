//
//  HomeScreenGameScene.swift
//  Ball Bouncer
//
//  Created by Cameron Byers on 6/30/16.
//  Copyright © 2016 Cameron Byers. All rights reserved.
//

import SpriteKit
import AVFoundation
import UIKit

class HomeScreenGameScene: SKScene {
    
    var balls = [Ball]()
    var ballRadius: CGFloat!
    var standardButton: SKSpriteNode!
    var speedButton: SKSpriteNode!
    var multiplyButton: SKSpriteNode!
    var instructionButton: SKLabelNode!
    var audio: AVAudioPlayer!
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        loadBackground()
        loadBalls()
        loadTitle()
        loadStandardButton()
        loadSpeedButton()
        loadMultiplyButton()
        loadInstructionButton()
        playSound()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        // Loop over all the touches in this event
        for touch: AnyObject in touches {
            // Get the location of the touch in this scene
            let location = touch.locationInNode(self)
            // Check if the location of the touch is within the button's bounds
            if standardButton.containsPoint(location) {
                buttonTouchAnimation("Standard")
                
                let triggerTime = ((Int64(NSEC_PER_SEC) * 1)/4)
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
                    let transition = SKTransition.revealWithDirection(.Up, duration: 1.0)
                    
                    let nextScene = StandardGameScene(size: self.scene!.size)
                    nextScene.scaleMode = .AspectFill
                    
                    self.scene?.view?.presentScene(nextScene, transition: transition)
                    self.stopSound()
                })

            }
            else if speedButton.containsPoint(location) {
                buttonTouchAnimation("Speed")
                
                let triggerTime = ((Int64(NSEC_PER_SEC) * 1)/4)
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
                    let transition = SKTransition.revealWithDirection(.Up, duration: 1.0)
                    
                    let nextScene = SpeedGameScene(size: self.scene!.size)
                    nextScene.scaleMode = .AspectFill
                    
                    self.scene?.view?.presentScene(nextScene, transition: transition)
                    self.stopSound()
                })

            }
            else if multiplyButton.containsPoint(location) {
                buttonTouchAnimation("Swarm")
                
                let triggerTime = ((Int64(NSEC_PER_SEC) * 1)/4)
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
                    let transition = SKTransition.revealWithDirection(.Up, duration: 1.0)
                    
                    let nextScene = MultiplyGameScene(size: self.scene!.size)
                    nextScene.scaleMode = .AspectFill
                    
                    self.scene?.view?.presentScene(nextScene, transition: transition)
                })
                stopSound()
            }
            else if instructionButton.containsPoint(location) {
                buttonTouchAnimationTwo(20)
                let triggerTime = ((Int64(NSEC_PER_SEC) * 1)/4)
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
                    let transition = SKTransition.revealWithDirection(.Up, duration: 1.0)
                    
                    let nextScene = InstructionsGameScene(size: self.scene!.size)
                    nextScene.scaleMode = .AspectFill
                    
                    self.scene?.view?.presentScene(nextScene, transition: transition)
                })
                stopSound()
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        moveBalls()
    }
    
    
    
    // Load Functions
    
    func loadBackground() {
        let background = SKSpriteNode(imageNamed: "background")
        background.size = CGSizeMake(frame.width, frame.height + 100)
        background.position = CGPointMake(frame.midX, frame.midY - 50)
        addChild(background)
    }
    
    func loadTitle() {
        let title = SKSpriteNode(imageNamed: "Title")
        title.size = CGSizeMake(frame.width - 50, frame.width * (1/2))
        title.position = CGPointMake(frame.midX, frame.height * (4/5))
        addChild(title)
    }
    
    func loadStandardButton() {
        standardButton = SKSpriteNode(imageNamed: "Standard")
        standardButton.size = CGSizeMake(130, 130)
        standardButton.position = CGPointMake(frame.midX - 70, frame.height * (2/8) + 125)
        addChild(standardButton)
    }
    
    func loadSpeedButton() {
        speedButton = SKSpriteNode(imageNamed: "Speed")
        speedButton.size = CGSizeMake(130, 130)
        speedButton.position = CGPointMake(frame.midX + 70, frame.height * (2/8) + 125)
        addChild(speedButton)
    }
    
    func loadMultiplyButton() {
        multiplyButton = SKSpriteNode(imageNamed: "Swarm")
        multiplyButton.size = CGSizeMake(130, 130)
        multiplyButton.position = CGPointMake(frame.midX, frame.height * (2/8))
        addChild(multiplyButton)
    }
    
    func loadInstructionButton() {
        instructionButton = SKLabelNode(text: "How to Play!")
        instructionButton.fontName = "Marker Felt"
        instructionButton.fontColor = UIColor.blackColor()
        instructionButton.fontSize = CGFloat(20)
        instructionButton.position = CGPointMake(frame.midX, 25)
        addChild(instructionButton)
    }
    
    func loadBalls() {
        ballRadius = frame.width * (1/10)
        let ballOne = Ball(radius: ballRadius, xPos: frame.midX - 55, yPos: frame.midY, xS: 3, yS: 3, physics: false)
        let ballTwo = Ball(radius: ballRadius * 1.5, xPos: frame.midX + 45, yPos: frame.midY, xS: -3, yS: -3, physics: false)
        let ballThree = Ball(radius: ballRadius, xPos: 100, yPos: frame.height - 40, xS: 2, yS: -2, physics: false)
        let ballFour = Ball(radius: ballRadius, xPos: 100, yPos: 55, xS: 2, yS: 2, physics: false)
        let ballFive = Ball(radius: ballRadius * 1.25, xPos: frame.width - 100, yPos: 55, xS: -4, yS: 4, physics: false)
        let ballSix = Ball(radius: ballRadius, xPos: frame.width - 100, yPos: frame.height - 45, xS: -5, yS: -5, physics: false)
        let ballSeven = Ball(radius: ballRadius * 1.5, xPos: 77, yPos: 350, xS: 4, yS: 4, physics: false)
        let ballEight = Ball(radius: ballRadius * 0.75, xPos: 144, yPos: 146, xS: -3, yS: -3, physics: false)
        let ballNine = Ball(radius: ballRadius * 0.5, xPos: frame.midX, yPos: frame.midY, xS: -4, yS: 4, physics: false)
        balls.append(ballOne)
        balls.append(ballTwo)
        balls.append(ballThree)
        balls.append(ballFour)
        balls.append(ballFive)
        balls.append(ballSix)
        balls.append(ballSeven)
        balls.append(ballEight)
        balls.append(ballNine)
        addChild(ballOne)
        addChild(ballTwo)
        addChild(ballThree)
        addChild(ballFour)
        addChild(ballFive)
        addChild(ballSix)
        addChild(ballSeven)
        addChild(ballEight)
        addChild(ballNine)
    }
    
    //-----------------------------------------------------
    
    func playSound() {
        let path = NSBundle.mainBundle().pathForResource("Inspired.mp3", ofType:nil)!
        let url = NSURL(fileURLWithPath: path)
        
        do {
            let sound = try AVAudioPlayer(contentsOfURL: url)
            audio = sound
            sound.play()
        } catch {
            // couldn't load file :(
        }
    }
    
    func stopSound() {
        if audio != nil {
            audio.stop()
            audio = nil
        }
    }
    
    func moveBalls() {
        for ball in balls {
            
            if ball.x + ballRadius >= frame.width {
                ball.xSpeed = CGFloat(abs(ball.xSpeed)) * (-1)
                ball.changeColor()
            }
            else if ball.x - ballRadius <= 0 {
                ball.xSpeed = CGFloat(abs(ball.xSpeed))
                ball.changeColor()
            }
            else if ball.y + ballRadius >= frame.height {
                ball.ySpeed = CGFloat(abs(ball.ySpeed)) * (-1)
                ball.changeColor()
            }
            else if ball.y - ballRadius <= 0 {
                ball.ySpeed = CGFloat(abs(ball.ySpeed))
                ball.changeColor()
            }
            
            ball.constantMovement()
        }
    }
    
    func buttonTouchAnimation(button: String) {
        
        if button == "Standard" {
            standardButton.runAction(SKAction.moveTo(CGPointMake(standardButton.position.x + 20, standardButton.position.y - 20), duration: 0.25))
            standardButton.runAction(SKAction.playSoundFileNamed("bounce.wav", waitForCompletion: false))
        }
        else if button == "Speed" {
            speedButton.runAction(SKAction.moveTo(CGPointMake(speedButton.position.x - 20, speedButton.position.y - 20), duration: 0.25))
            speedButton.runAction(SKAction.playSoundFileNamed("bounce.wav", waitForCompletion: false))
        }
        else if button == "Swarm" {
            multiplyButton.runAction(SKAction.moveTo(CGPointMake(multiplyButton.position.x, multiplyButton.position.y + 20), duration: 0.25))
            multiplyButton.runAction(SKAction.playSoundFileNamed("bounce.wav", waitForCompletion: false))
        }
        
        
    }
    
    func buttonTouchAnimationTwo(y: CGFloat) {
        let ballOne = SKSpriteNode(imageNamed: "red")
        ballOne.size = CGSizeMake(30, 30)
        ballOne.position = CGPointMake(25, y + 15)
        addChild(ballOne)
        ballOne.runAction(SKAction.moveToX(75, duration: 0.25))
        ballOne.runAction(SKAction.playSoundFileNamed("bounce.wav", waitForCompletion: false))
        
        let ballTwo = SKSpriteNode(imageNamed: "red")
        ballTwo.size = CGSizeMake(30, 30)
        ballTwo.position = CGPointMake(frame.width - 25, y + 15)
        addChild(ballTwo)
        ballTwo.runAction(SKAction.moveToX(frame.width - 75, duration: 0.25))
        
        let triggerTime = ((Int64(NSEC_PER_SEC) * 1)/4)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
            ballOne.removeFromParent()
            ballTwo.removeFromParent()
        })
        
    }
    
}
