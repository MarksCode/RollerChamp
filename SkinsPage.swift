//
//  SkinsPage.swift
//  RollerChamp
//
//  Created by Ron marks on 8/18/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class SkinsPageFuncs: CCNode {
    
    weak var firstBall: CCSprite!
    weak var secondBall: CCSprite!
    weak var thirdBall: CCSprite!
    weak var fourthBall: CCSprite!
    weak var fifthBall: CCSprite!
    weak var sixthBall: CCSprite!
    
    weak var text1: CCLabelTTF!
    weak var text2: CCLabelTTF!
    weak var text3: CCLabelTTF!
    weak var text4: CCLabelTTF!
    weak var text5: CCLabelTTF!
    
    var ballArray: [CCSprite] = []
    
    func didLoadFromCCB() {
        ballArray = [firstBall, secondBall, thirdBall, fourthBall, fifthBall, sixthBall]
        
        
        for var x = 1; x < 6; x++ {
            let ball = ballArray[x]
            ball.opacity = 0.5
            ball.color = CCColor.darkGrayColor()
        }
        
        
        let state = UserState()
        
        
        // Unlocked Skin 2
        if state.unlockSkin1 {
            secondBall.color = CCColor.whiteColor()
            secondBall.opacity = 1.0
            text1.string = ""
        }
        // Unlocked Skin 3
        if state.unlockSkin2 {
            thirdBall.color = CCColor.whiteColor()
            thirdBall.opacity = 1.0
            text2.string = ""
        }
        // Unlocked Skin 4
        if state.unlockSkin3 {
            fourthBall.color = CCColor.whiteColor()
            fourthBall.opacity = 1.0
            text3.string = ""
        }
        // Unlocked Skin 5
        if state.unlockSkin4 {
            fifthBall.color = CCColor.whiteColor()
            fifthBall.opacity = 1.0
            text4.string = ""
        }
        // Unlocked Skin 6
        if state.unlockSkin5 {
            sixthBall.color = CCColor.whiteColor()
            sixthBall.opacity = 1.0
            text5.string = ""
        }

        
        // Previous Skin Picked
    
        if state.skinNum == 0 {
            firstBall.scale = 2.5
        } else if state.skinNum == 1 {
            secondBall.scale = 2.5
        } else if state.skinNum == 2 {
            thirdBall.scale = 2.5
        } else if state.skinNum == 3 {
            fourthBall.scale = 2.5
        } else if state.skinNum == 4 {
            fifthBall.scale = 2.5
        } else {
            sixthBall.scale = 2.5
        }
    }
    
    
    
    func ball1() {
        let state = UserState()
        if state.skinNum != 0 {
            state.skinNum = 0
            
            firstBall.scale = 2.5
            secondBall.scale = 2
            thirdBall.scale = 2
            fourthBall.scale = 2
            sixthBall.scale = 2
            fifthBall.scale = 2
        }
    }
    func ball2() {
        let state = UserState()
        if state.unlockSkin1 {
            if state.skinNum != 1 {
                state.skinNum = 1
                
                secondBall.scale = 2.5
                firstBall.scale = 2
                thirdBall.scale = 2
                fourthBall.scale = 2
                sixthBall.scale = 2
                fifthBall.scale = 2
            }
        }
    }
    func ball3() {
        let state = UserState()
        if state.unlockSkin2 {
            if state.skinNum != 2 {
                state.skinNum = 2
                
                thirdBall.scale = 2.5
                firstBall.scale = 2
                secondBall.scale = 2
                fourthBall.scale = 2
                sixthBall.scale = 2
                fifthBall.scale = 2
            }
        }
    }
    func ball4() {
        let state = UserState()
        if state.unlockSkin3 {
            if state.skinNum != 3 {
                state.skinNum = 3
                
                fourthBall.scale = 2.5
                thirdBall.scale = 2
                firstBall.scale = 2
                secondBall.scale = 2
                sixthBall.scale = 2
                fifthBall.scale = 2
                
            }
        }
    }
    func ball5() {
        let state = UserState()
        if state.unlockSkin4 {
            if state.skinNum != 4 {
                state.skinNum = 4
                
                fourthBall.scale = 2
                thirdBall.scale = 2
                firstBall.scale = 2
                secondBall.scale = 2
                fifthBall.scale = 2.5
                sixthBall.scale = 2
                
            }
        }
    }
    func ball6() {
        let state = UserState()
        if state.unlockSkin5 {
            if state.skinNum != 5 {
                state.skinNum = 5
                
                fourthBall.scale = 2
                thirdBall.scale = 2
                firstBall.scale = 2
                secondBall.scale = 2
                sixthBall.scale = 2.5
                fifthBall.scale = 2
                
                
            }
        }
    }

    
    func back() {
        let menu = CCBReader.loadAsScene("MainScene")
        CCDirector.sharedDirector().replaceScene(menu)
    }

}
