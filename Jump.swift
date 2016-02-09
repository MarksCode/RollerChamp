//
//  Jump.swift
//  RollerChamp
//
//  Created by Ron marks on 7/27/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class Jump: CCSprite {

    func animate() {
        self.physicsBody.collisionType = ""
        self.animationManager.runAnimationsForSequenceNamed("Shine")
        scheduleBlock({ (time) -> Void in
            self.removeFromParent()
            }, delay: 0.5)
    }
    
   
    
}