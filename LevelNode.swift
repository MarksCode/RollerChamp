//
//  LevelNode.swift
//  RollerChamp
//
//  Created by Ron marks on 7/20/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

public var levelNum: Int = 0
public var levelNumString: String = ""


class LevelNode: CCNode {
    weak var world1Txt: CCLabelTTF!
    weak var world2Txt: CCLabelTTF!
    var level: CCScene!

    func playLevel(button: CCButton) {
        levelNumString = (button.name)
        levelNum = levelNumString.toInt()!
        let gameplay = CCBReader.loadAsScene("GamePlay")
        CCDirector.sharedDirector().presentScene(gameplay)
    }
    
     func didLoadFromCCB() {
        
       let screenSizeX = UIScreen.mainScreen().bounds.width
        let screenSizeY = UIScreen.mainScreen().bounds.height
        let butSizeX = screenSizeX / 6 - 5
       // Resize
        for var x = 1; x<73; x++ {
            var button: CCButton = getChildByName("\(x)", recursively: true) as! CCButton
            button.maxSize.width = butSizeX
        }
        // Disable all
        for var z = 2; z<73; z++ {
            var button: CCButton = getChildByName("\(z)", recursively: true) as! CCButton
            button.state = .Disabled
            button.setBackgroundOpacity(0.4, forState: .Disabled)
            button.setLabelOpacity(0.4, forState: .Disabled)
        }
       let state = UserState()
        let unlockedLevel = state.unlockedLevel
        
        // Unlock World 1 Levels
        
        for var y = 1; y <= unlockedLevel; y++ {
            if y < 25 {
                var but: CCButton = getChildByName("\(y)", recursively: true) as! CCButton
                but.state = .Normal
                but.setBackgroundOpacity(1.0, forState: .Normal)
                but.setLabelOpacity(1.0, forState: .Normal)
            }
        }
        
        // Unlock World 2 Levels
        
        for var y = 25; y <= unlockedLevel; y++ {
            if y < 49 && state.unlockWorld1 {
                var but: CCButton = getChildByName("\(y)", recursively: true) as! CCButton
                but.state = .Normal
                but.setBackgroundOpacity(1.0, forState: .Normal)
                but.setLabelOpacity(1.0, forState: .Normal)
            }
        }
        
        // Unlock World 3 Levels

        for var y = 49; y <= unlockedLevel; y++ {
            if y < 73 && state.unlockWorld2 {
                var but: CCButton = getChildByName("\(y)", recursively: true) as! CCButton
                but.state = .Normal
                but.setBackgroundOpacity(1.0, forState: .Normal)
                but.setLabelOpacity(1.0, forState: .Normal)
            }
        }
        
        var totesStars: Int = 0
        
        for var x = 0; x < 73; x++ {
            totesStars += state.starArray[x]
            if totesStars > 44 {
                world1Txt.string = "World 2"
            }
            if totesStars > 89 {
                world2Txt.string = "World 3"
            }
        }
        
        
    }

    
    
}
