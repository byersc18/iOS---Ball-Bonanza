//
//  ViewController.swift
//  Ball Bouncer
//
//  Created by Cameron Byers on 6/30/16.
//  Copyright © 2016 Cameron Byers. All rights reserved.
//

import UIKit
import SpriteKit

class HomeScreenViewController: UIViewController {
    
    var scene: HomeScreenGameScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Configure the view
        let skView = view as! SKView
        skView.multipleTouchEnabled = false
        
        //Create and configure the scene
        scene = HomeScreenGameScene(size: skView.bounds.size)
        scene.scaleMode = .AspectFill
        
        //present scene
        skView.presentScene(scene)
        
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}

