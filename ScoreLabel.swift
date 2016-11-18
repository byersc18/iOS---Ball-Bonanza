//
//  ScoreLabel.swift
//  Ball Bouncer
//
//  Created by Cameron Byers on 6/30/16.
//  Copyright © 2016 Cameron Byers. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class ScoreLabel: SKLabelNode  {
    
    var number = 0
    
    init(num: Int) {
        super.init()
        
        fontColor = UIColor.blackColor()
        
        number = num
        text = "\(num)"
    }
    
    func increment() {
        number += 1
        text = "\(number)"
    }
    
    func setTo(num: Int) {
        self.number = num
        text = "\(self.number)"
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
