//
//  UserState.swift
//  RollerChamp
//
//  Created by Ron marks on 8/8/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

public class UserState {
    
    var starArray: [Int] = NSUserDefaults.standardUserDefaults().arrayForKey("starsArray") as? [Int] ??  [Int](count: 73, repeatedValue:0)  {
       didSet {
            NSUserDefaults.standardUserDefaults().setObject(starArray, forKey:"starsArray")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
   }
    
    var unlockedLevel: Int = NSUserDefaults.standardUserDefaults().integerForKey("unlockedLevel") {
        didSet {
            NSUserDefaults.standardUserDefaults().setInteger(unlockedLevel, forKey:"unlockedLevel")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    var skinNum: Int = NSUserDefaults.standardUserDefaults().integerForKey("skinNumber")  {
        didSet {
            NSUserDefaults.standardUserDefaults().setInteger(skinNum, forKey:"skinNumber")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    var unlockWorld1: Bool = NSUserDefaults.standardUserDefaults().boolForKey("world1")  {
        didSet {
            NSUserDefaults.standardUserDefaults().setBool(unlockWorld1, forKey:"world1")
            NSUserDefaults.standardUserDefaults().synchronize()

        }
    }
    
    var unlockWorld2: Bool = NSUserDefaults.standardUserDefaults().boolForKey("world2") {
        didSet {
            NSUserDefaults.standardUserDefaults().setBool(unlockWorld2, forKey:"world2")
            NSUserDefaults.standardUserDefaults().synchronize()
            
        }
    }
    var unlockSkin1: Bool = NSUserDefaults.standardUserDefaults().boolForKey("skin1") {
        didSet {
            NSUserDefaults.standardUserDefaults().setBool(unlockSkin1, forKey:"skin1")
            NSUserDefaults.standardUserDefaults().synchronize()
            
        }
    }
    var unlockSkin2: Bool = NSUserDefaults.standardUserDefaults().boolForKey("skin2") {
        didSet {
            NSUserDefaults.standardUserDefaults().setBool(unlockSkin2, forKey:"skin2")
            NSUserDefaults.standardUserDefaults().synchronize()
            
        }
    }
    var unlockSkin3: Bool = NSUserDefaults.standardUserDefaults().boolForKey("skin3") {
        didSet {
            NSUserDefaults.standardUserDefaults().setBool(unlockSkin3, forKey:"skin3")
            NSUserDefaults.standardUserDefaults().synchronize()
            
        }
    }
    var unlockSkin4: Bool = NSUserDefaults.standardUserDefaults().boolForKey("skin4") {
        didSet {
            NSUserDefaults.standardUserDefaults().setBool(unlockSkin4, forKey:"skin4")
            NSUserDefaults.standardUserDefaults().synchronize()
            
        }
    }
    var unlockSkin5: Bool = NSUserDefaults.standardUserDefaults().boolForKey("skin5") {
        didSet {
            NSUserDefaults.standardUserDefaults().setBool(unlockSkin5, forKey:"skin5")
            NSUserDefaults.standardUserDefaults().synchronize()
            
        }
    }
}