//
//  Key.swift
//  RollerChamp
//
//  Created by Ron marks on 7/23/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class Key: CCSprite {
    
    func animate(point: CGPoint){
        let open = CCActionMoveTo(duration: 1.0, position: point)
        self.runAction(open)
        let fadeOut = CCActionFadeOut(duration: 1.2)
        self.runAction(fadeOut)
        
    }

}
