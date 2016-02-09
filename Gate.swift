//
//  Gate.swift
//  RollerChamp
//
//  Created by Ron marks on 7/23/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class Gate: CCNode {
    
    func animate(point: CGPoint){
        
        let open = CCActionMoveBy(duration: 0.5, position: point)
        self.runAction(open)
    }
    
}