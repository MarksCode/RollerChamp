//
//  Potion.swift
//  RollerChamp
//
//  Created by Ron marks on 7/24/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class Potion: CCSprite {
    
    func animate() {

        self.animationManager.runAnimationsForSequenceNamed("Shine")
        scheduleBlock({ (time) -> Void in
            self.removeFromParent()
            }, delay: 0.5)
    }
    
}