//
//  MainScene.swift
//  RollerChamp
//
//  Created by Ron marks on 7/24/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

//import Foundation

class MainScene: CCNode {
    
    weak var stencilNode: CCNode!
    weak var clipNode: CCClippingNode!
    weak var totalStarsTxt: CCLabelTTF!
    var totalStars: Int = 0
    
    func didLoadFromCCB() {
        
        clipNode.stencil = stencilNode
        clipNode.alphaThreshold = 0.0
        
        let state = UserState()
        let starRay = state.starArray
        for var x = 0; x < starRay.count; x++ {
            totalStars += starRay[x]
        }
        totalStarsTxt.string = "\(totalStars)"
    } 
    
    func skins() {
        let SkinsMenu = CCBReader.loadAsScene("SkinsPage")
        CCDirector.sharedDirector().replaceScene(SkinsMenu)
    }
    
    
}
