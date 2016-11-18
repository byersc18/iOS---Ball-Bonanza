//
//  StandardGameScene.swift
//  Ball Bouncer
//
//  Created by Cameron Byers on 6/30/16.
//  Copyright © 2016 Cameron Byers. All rights reserved.
//

import SpriteKit

class StandardGameScene: SKScene, SKPhysicsContactDelegate {
    
    var ball: Ball!
    var ballRadius: CGFloat!
    var speedMultiplier = 5.0
    var angleX: Double = 0.0
    var angleY: Double = 0.0
    
    var squareOne: Square!
    var squareTwo: Square!
    var squareThree: Square!
    var squareFour: Square!
    var squares = [Square]()
    var sideLength: CGFloat!
    
    var tapX: CGFloat!
    var tapY: CGFloat!
    
    var gameStarted = false
    var gameOver = false
    
    var endButton: SKLabelNode!
    var restartButton: SKLabelNode!
    
    var scoreLabel: ScoreLabel!
    var highScoreLabel: ScoreLabel!
    
    var sceneBody: SKPhysicsBody!
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        loadBackground()
        loadPhysicsBody()
        loadBall()
        loadSquares()
        loadTapToStartLabel()
        loadScoreLabel()
        loadHighScoreLabel()
        loadHighScore()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        if gameStarted == false {
            gameStarted = true
            let tapToStartLabel = childNodeWithName("tapToStartLabel")
            tapToStartLabel?.removeFromParent()
            
            if let touch = touches.first {
                var position :CGPoint = touch.locationInView(view)
                position = convertPointFromView(position)
                tapX = position.x
                tapY = position.y
                
                squareOne.xSpeed = 3.0
                squareOne.ySpeed = -3.0

                
                ball.changeColor()
                calculateDirection()
                playSound()
            }
        }
        else if gameOver == true {
            for touch: AnyObject in touches {
                let location = touch.locationInNode(self)
                if restartButton.containsPoint(location) {
                    buttonTouchAnimation(frame.height * (3/5))
                    
                    let triggerTime = ((Int64(NSEC_PER_SEC) * 1)/4)
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
                        self.restart()
                    })
                }
                else if endButton.containsPoint(location) {
                    buttonTouchAnimation(frame.height * (2/5))
                    let triggerTime = ((Int64(NSEC_PER_SEC) * 1)/4)
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
                        let transition = SKTransition.revealWithDirection(.Up, duration: 1.0)
                        
                        let nextScene = HomeScreenGameScene(size: self.scene!.size)
                        nextScene.scaleMode = .AspectFill
                        
                        self.scene?.view?.presentScene(nextScene, transition: transition)
                    })
                }
            }
        }
        else {
            if let touch = touches.first {
                var position :CGPoint = touch.locationInView(view)
                position = convertPointFromView(position)
                tapX = position.x
                tapY = position.y
                ball.changeColor()
                calculateDirection()
                playSound()
            }
        }

    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if gameOver == false {
            if scoreLabel.number == 10 {
                squareTwo.xSpeed = -3.25
                squareTwo.ySpeed = -3.25
            }
            else if scoreLabel.number == 40 {
                squareThree.xSpeed = 3.5
                squareThree.ySpeed = 3.5
            }
            else if scoreLabel.number == 80 {
                squareFour.xSpeed = -4.0
                squareFour.ySpeed = 4.0
            }
            ball.directionMovement(speedMultiplier, angleX: angleX, angleY: angleY)
            moveSquares()
        }
    }
    
    
    //Load Functions
    
    func loadBackground() {
        let background = SKSpriteNode(imageNamed: "background")
        background.size = CGSizeMake(frame.width, frame.height + 100)
        background.position = CGPointMake(frame.midX, frame.midY - 50)
        addChild(background)
    }
    
    func loadBall() {
        ballRadius = frame.width/16
        ball = Ball(radius: ballRadius, xPos: frame.midX, yPos: frame.midY, xS: 0, yS: 0, physics: true)
        addChild(ball)
    }
    
    func loadSquares() {
        sideLength = frame.width/12
        squareOne = Square(sideLength: sideLength, xPos: frame.width * (1/7), yPos: frame.height * (9/10), xS: 0, yS: 0)
        squareTwo = Square(sideLength: sideLength, xPos: frame.width * (6/7), yPos: frame.height * (9/10), xS: 0, yS: 0)
        squareThree = Square(sideLength: sideLength, xPos: frame.width * (1/7), yPos: frame.height * (1/10), xS: 0, yS: 0)
        squareFour = Square(sideLength: sideLength, xPos: frame.width * (6/7), yPos: frame.height * (1/10), xS: 0, yS: 0)
        squares.append(squareOne)
        squares.append(squareTwo)
        squares.append(squareThree)
        squares.append(squareFour)
        addChild(squareOne)
        addChild(squareTwo)
        addChild(squareThree)
        addChild(squareFour)
    }
    
    func loadTapToStartLabel() {
        let tapToStartLabel = SKLabelNode(text: "Tap to start!")
        tapToStartLabel.name = "tapToStartLabel"
        tapToStartLabel.fontName = "Marker Felt"
        tapToStartLabel.position.x = frame.midX
        tapToStartLabel.position.y = frame.midY + 100
        tapToStartLabel.fontColor = UIColor.blackColor()
        tapToStartLabel.fontSize = 50
        addChild(tapToStartLabel)
    }
    
    func loadPhysicsBody() {
        physicsWorld.contactDelegate = self
        sceneBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        self.physicsBody = sceneBody
        self.physicsBody?.categoryBitMask = PhysicsCategory.border
        self.physicsBody?.contactTestBitMask = PhysicsCategory.ball
        self.physicsBody?.collisionBitMask = PhysicsCategory.square
    }
    
    func loadEndGameButton() {
        endButton = SKLabelNode(text: "End Game")
        endButton.fontSize = CGFloat(50)
        endButton.fontColor = UIColor.blackColor()
        endButton.fontName = "Marker Felt"
        endButton.position = CGPointMake(frame.midX, frame.height * (2/5))
        addChild(endButton)
    }
    
    func loadRestartButton() {
        restartButton = SKLabelNode(text: "Restart")
        restartButton.fontName = "Marker Felt"
        restartButton.fontSize = CGFloat(50)
        restartButton.position = CGPointMake(frame.midX, frame.height * (3/5))
        restartButton.fontColor = UIColor.blackColor()
        addChild(restartButton)
    }
    
    func loadScoreLabel() {
        scoreLabel = ScoreLabel(num: 0)
        scoreLabel.name = "pointsLabel"
        scoreLabel.position.x = frame.width - 40
        scoreLabel.position.y = 20
        scoreLabel.fontSize = 50
        scoreLabel.fontName = "Marker Felt"
        addChild(scoreLabel)
    }
    
    func loadHighScoreLabel() {
        highScoreLabel = ScoreLabel(num: 0)
        highScoreLabel.name = "highScoreLabel"
        highScoreLabel.position.x = 40
        highScoreLabel.position.y = 20
        highScoreLabel.fontSize = 50
        highScoreLabel.fontName = "Marker Felt"
        addChild(highScoreLabel)
    }
    
    func loadHighScore() {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        let highScoreLabel = childNodeWithName("highScoreLabel") as! ScoreLabel
        highScoreLabel.setTo(defaults.integerForKey("Standard"))
    }

    //-----------------------------------------
    
    func didBeginContact(contact: SKPhysicsContact) {
        endGame()
    }
    
    func calculateDirection() {
        
        let circleX = Double(ball.x)
        let circleY = Double(ball.y)
        let tX = Double(tapX)
        let tY = Double(tapY)
        
        let c = ((circleX - tX)*(circleX - tX)) + ((circleY - tY)*(circleY - tY))
        let d = sqrt(c)
        
        angleX = (circleX - tX)/d
        angleY = (circleY - tY)/d
    }
    
    func moveSquares() {
        for square in squares {
            
            if square.x + (sideLength/2) >= frame.width {
                square.xSpeed = -1 * CGFloat(abs(square.xSpeed))
                scoreLabel.increment()
            }
            else if square.x - (sideLength/2) <= 0 {
                square.xSpeed = CGFloat(abs(square.xSpeed))
                scoreLabel.increment()
            }
            else if square.y + (sideLength/2) >= frame.height {
                square.ySpeed = -1 * CGFloat(abs(square.ySpeed))
                scoreLabel.increment()
            }
            else if square.y - (sideLength/2) <= 0 {
                square.ySpeed = CGFloat(abs(square.ySpeed))
                scoreLabel.increment()
            }
            
            square.constantMovement()
        }
    }
    
    func playSound() {
        ball.runAction(SKAction.playSoundFileNamed("bounce.wav", waitForCompletion: false))
    }
    
    func buttonTouchAnimation(y: CGFloat) {
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
    
    func endGame() {
        gameOver = true
        loadEndGameButton()
        loadRestartButton()
        speedMultiplier = 0.0
        
        squareOne.xSpeed = 0
        squareOne.ySpeed = 0
        squareTwo.xSpeed = 0
        squareTwo.ySpeed = 0
        squareThree.xSpeed = 0
        squareThree.ySpeed = 0
        squareFour.xSpeed = 0
        squareFour.ySpeed = 0
        
        let pointsLabel = childNodeWithName("pointsLabel") as! ScoreLabel
        let highScoreLabel = childNodeWithName("highScoreLabel") as! ScoreLabel
        
        if highScoreLabel.number < pointsLabel.number {
            highScoreLabel.setTo(pointsLabel.number)
            
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setInteger(highScoreLabel.number, forKey: "Standard")
        }
    }
    

    func restart() {
        let newScene = StandardGameScene(size: view!.bounds.size)
        newScene.scaleMode = .AspectFill
        
        view!.presentScene(newScene)
    }
}
