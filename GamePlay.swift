//
//  GamePlay.swift
//  RollerChamp
//
//  Created by Ron marks on 7/7/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import UIKit
import CoreMotion



class GamePlay: CCNode, CCPhysicsCollisionDelegate {
    
    // Vars
    
    weak var gamePhysicsNode : CCPhysicsNode!
    
    weak var character: CCSprite!
    weak var characterMini: CCSprite!
    weak var pausePic: CCSprite!
    weak var pathOutline: CCSprite!
    weak var platform: CCSprite!
    var lastPlatform: CCSprite!
    weak var ball1: CCSprite!
    weak var ball2: CCSprite!
    weak var starNum1: CCSprite!
    weak var starNum2: CCSprite!
    weak var starNum3: CCSprite!
    var star1: CCSprite!
    var star2: CCSprite!
    var star3: CCSprite!
    var cloud1: CCSprite!
    var cloud2: CCSprite!
    var cloud3: CCSprite!
    var cloud4: CCSprite!
    var platformArray: [CCSprite] = []
    var clouds = [CCSprite]()
    
    weak var startLoc: CCNode!
    weak var noDrawNode: CCNode!
    weak var flingNode: CCNode!
    weak var gateLoc: CCNode!
    weak var charLocator: CCNode!
    weak var buttonsNode: CCNode!
    weak var keyLoc: CCNode!
    weak var upPicture: CCNode!
    weak var ballLocator: CCNode!
    weak var ballLocator2: CCNode!
    weak var charAnim: CCNode!
    
    weak var lvlLabel: CCLabelTTF!
    weak var lvlText: CCLabelTTF!
    weak var recordTxt: CCLabelTTF!
    var backButton: CCButton!
    var pauseButt: CCButton!
    var jumpButton: CCButton!
    weak var dragNode1: CCNodeColor!
    weak var dragNode2: CCNodeColor!
    var dragColor: CCColor!

    weak var level: Level!
    weak var gate: Gate!
    weak var key: Key!
    weak var potion: Potion!
    weak var jumpNode: Jump!
    weak var jumpNode2: Jump!

    let midScreen: CGPoint = CGPointMake(UIScreen.mainScreen().bounds.width/2, UIScreen.mainScreen().bounds.height/2)
    var jumpPoint: CGPoint!
    var jumpPoint2: CGPoint!
    var jumpLoc: CGPoint!
    var pauseVelocity: CGPoint!
    var cloudVel: CGPoint!
    var location: CGPoint!
    var location2: CGPoint!
    var ball1Loc: CGPoint!
    var ball2Loc: CGPoint!
    var point: CGPoint!
    var mathPos: CGPoint!
    var keyPos: CGPoint!
    var gatePos: CGPoint!
    var jumpPos: CGPoint!
    
    var length: CGFloat!
    var disUsed: CGFloat!
    var halfStar: CGFloat = 0
    var scaleFactor: Float!
   
    var isGameOver: Bool = false
    var sparkleBool: Bool = false
    var isPotion: Bool = false
    var isGateOpen: Bool = false
    var isChange: Bool = false
    var isNewBall: Bool = false
    var isAnim: Bool = false
    var isNoDrag: Bool = false
    var recurBool: Bool = false
    var isJump: Bool = false
    var jumpTouched: Bool = false
    var isGamePaused: Bool = false
    var isHidden: Bool = false
    var isKeyMove: Bool = false
    var isLineIntersectBall: Bool = false

    var distanceUsed: Int!
    var numBalls: Int = 0
    var onestar: Int = 0
    var twostar: Int = 0
    var gateX: Int = 0
    var gateY: Int = 0
    let farWidth: Double = Double(UIScreen.mainScreen().bounds.width)
    
    //Science
    
    var motionManager: CMMotionManager! = CMMotionManager()
   
    
    
// Update Function //
    
    override func update(delta: CCTime) {
        
        if cloud1.position.x > UIScreen.mainScreen().bounds.width {
            cloud1.position = CGPointMake(-100.0, cloud1.position.y)
        }
        if cloud2.position.x > UIScreen.mainScreen().bounds.width {
            cloud2.position = CGPointMake(-100.0, cloud2.position.y)

        }
        if cloud3.position.x > UIScreen.mainScreen().bounds.width {
            cloud3.position = CGPointMake(-100.0, cloud3.position.y)

        }
        if cloud4.position.x > UIScreen.mainScreen().bounds.width {
            cloud4.position = CGPointMake(-100.0, cloud4.position.y)
            
        }
        if !isGameOver{
            
            if isNewBall{
                flingNode.position = characterMini.position
            } else {
                if !isChange{
                    charLocator.position = character.position
                }
            }
            if !isChange {
                if let accelerometerData: CMAccelerometerData = motionManager.accelerometerData {
                    let acceleration: CMAcceleration = accelerometerData.acceleration
                    let accelFloat: CGFloat = CGFloat(acceleration.y)
                  
                   var newXPos: CGFloat = character.physicsBody.velocity.x + accelFloat * 400.0 * CGFloat(delta)
                    character.physicsBody.velocity.x = newXPos
                    
                }
                if character.physicsBody.velocity.x > 200.0 {
                    character.physicsBody.velocity = ccp(200.0, character.physicsBody.velocity.y)
                }
                if character.physicsBody.velocity.y > 200.0 {
                    character.physicsBody.velocity = ccp(character.physicsBody.velocity.x, 200.0)
                }
                if character.position.y < CGFloat(-40){
                    if isKeyMove{
                        key.stopAllActions()
                        key.position = keyPos
                        isKeyMove = false
                        gate.stopAllActions()
                        moveGateBack()
                        isGateOpen = false
                        key.physicsBody.sensor = false
                        key.opacity = 1.0
                    }
                    character.physicsBody.velocity = ccp(0, 0)
                    character.physicsBody.angularVelocity = 0.0
                    character.position = mathPos
                    let ouchNode = CCBReader.load("Ouch")
                    self.addChild(ouchNode)
                    if isGateOpen{
                        gate.stopAllActions()
                        moveGateBack()
                        key.position = keyPos
                        key.physicsBody.sensor = false
                        let fadeIn = CCActionFadeIn(duration: 0.5)
                        key.runAction(fadeIn)
                        isGateOpen = false
                    }
                    
                }
                

            }
            
            // Other one
            
            if isNewBall {
                if let accelerometerData: CMAccelerometerData = motionManager.accelerometerData {
                    let acceleration: CMAcceleration = accelerometerData.acceleration
                    let accelFloat: CGFloat = CGFloat(acceleration.y)
                    
                    var newXPos: CGFloat = characterMini.physicsBody.velocity.x + accelFloat * 250.0 * CGFloat(delta)
                    characterMini.physicsBody.velocity.x = newXPos
                    
                }
                if characterMini.physicsBody.velocity.x > 150.0 {
                    characterMini.physicsBody.velocity = ccp(150.0, characterMini.physicsBody.velocity.y)
                }
                if characterMini.physicsBody.velocity.y > 150.0 {
                    characterMini.physicsBody.velocity = ccp(characterMini.physicsBody.velocity.x, 150.0)
                }
                if characterMini.position.y < CGFloat(-40){
                    let ouchNode = CCBReader.load("Ouch")
                    self.addChild(ouchNode)
                    if isKeyMove || isGateOpen{
                        gate.stopAllActions()
                        moveGateBack()
                        key.position = keyPos
                        key.physicsBody.sensor = false
                        let fadeIn = CCActionFadeIn(duration: 0.5)
                        key.runAction(fadeIn)
                        isGateOpen = false
                    }

                    characterMini.physicsBody.angularVelocity = 0
                    characterMini.physicsBody.velocity = ccp(0, 0)
                    characterMini.position = mathPos
                }
            }
        }
        if numBalls == 1{
            ballLocator.position = ball1.position
        }
        if numBalls == 2{
            ballLocator.position = ball1.position
            ballLocator2.position = ball2.position
        }
    }
    
    
// Exit Function //
    
    override func onExit() {
        
        motionManager.stopAccelerometerUpdates()
        super.onExit()
    }
    

// DidLoadCCB Function //
    
    func didLoadFromCCB() {
        var levelString = "Levels/Level\(levelNumString)"
        level = CCBReader.load(levelString, owner: self) as! Level
        startLoc = level.getChildByName("startLocation", recursively: true)
        gamePhysicsNode.addChild(level)
        onestar = level.onestar
        twostar = level.twostar
        numBalls = level.numBalls
        
        userInteractionEnabled = true
        gamePhysicsNode.collisionDelegate = self
        
        // Load Character Skin
        let state = UserState()
        if state.skinNum == 0 {
            character = CCBReader.load("Character") as! CCSprite
        } else if state.skinNum == 1 {
            character = CCBReader.load("CharacterB") as! CCSprite
        } else if state.skinNum == 2 {
            character = CCBReader.load("CharacterC") as! CCSprite
        } else if state.skinNum == 3 {
            character = CCBReader.load("CharacterD") as! CCSprite
        } else if state.skinNum == 4 {
            character = CCBReader.load("CharacterE") as! CCSprite
        } else {
            character = CCBReader.load("CharacterF") as! CCSprite
        }
        gamePhysicsNode.addChild(character)
        
        pathOutline = CCBReader.load("PathOutline") as! CCSprite
        self.addChild(pathOutline)
        charLocator = CCBReader.load("CharLocator")
        self.addChild(charLocator)
        
        motionManager.startAccelerometerUpdates()
        
        // Ball Stuff
        
        if numBalls == 1 {
            ball1 = getChildByName("ball1", recursively: true) as! CCSprite
            if ball1.positionType.corner == .TopRight {
                ball1Loc = CGPointMake(UIScreen.mainScreen().bounds.width - ball1.position.x, UIScreen.mainScreen().bounds.height - ball1.position.y)
            } else if ball1.positionType.corner == .BottomRight {
                ball1Loc = CGPointMake(UIScreen.mainScreen().bounds.width - ball1.position.x, ball1.position.y)
            } else if ball1.positionType.corner == .TopLeft {
                
                    ball1Loc = CGPointMake(ball1.position.x, UIScreen.mainScreen().bounds.height - ball1.position.y)
            } else {
                    ball1Loc = ball1.position
            }
            ball1.positionType.corner = .BottomLeft
            ball1.position = ball1Loc
            ballLocator.scale = Float(ball1.contentSize.height / 5.0)
        }
        if numBalls == 2 {
            ball1 = getChildByName("ball1", recursively: true) as! CCSprite
            ball2 = getChildByName("ball2", recursively: true) as! CCSprite
            if ball1.positionType.corner == .TopRight {
                ball1Loc = CGPointMake(UIScreen.mainScreen().bounds.width - ball1.position.x, UIScreen.mainScreen().bounds.height - ball1.position.y)
            } else if ball1.positionType.corner == .BottomRight {
                ball1Loc = CGPointMake(UIScreen.mainScreen().bounds.width - ball1.position.x, ball1.position.y)
            } else if ball1.positionType.corner == .TopLeft {
               
                    ball1Loc = CGPointMake(ball1.position.x, UIScreen.mainScreen().bounds.height - ball1.position.y)
                } else {
                    ball1Loc = ball1.position
                }
            
                
            if ball2.positionType.corner == .TopRight {
                ball2Loc = CGPointMake(UIScreen.mainScreen().bounds.width - ball2.position.x, UIScreen.mainScreen().bounds.height - ball2.position.y)
            } else if ball2.positionType.corner == .BottomRight {
                ball2Loc = CGPointMake(UIScreen.mainScreen().bounds.width - ball2.position.x, ball2.position.y)
            } else if ball2.positionType.corner == .TopLeft {
               
                    ball2Loc = CGPointMake(ball2.position.x, UIScreen.mainScreen().bounds.height - ball2.position.y)
                } else {
                    ball2Loc = ball2.position
                }
            
            ballLocator.scale = Float(ball1.contentSize.height / 5.0)
            ballLocator2.scale = Float(ball2.contentSize.height / 5.0)
            
            ball1.positionType.corner = .BottomLeft
            ball1.position = ball1Loc
            ball2.positionType.corner = .BottomLeft
            ball2.position = ball2Loc
        }
       
        dragColor = dragNode1.color
        jumpPoint = CGPointMake(0.0, 300.0)
        jumpPoint2 = CGPointMake(0.0, 250)
        disUsed = 0
        backButton.visible = false
        noDrawNode = self.getChildByName("noDrawNode", recursively: true)
        
        
    }

// On Enter Function //
    
    override func onEnter() {
        super.onEnter()
        cloudVel = CGPointMake(15.0, 0.0)
        cloud1.physicsBody.sensor = true; cloud2.physicsBody.sensor = true; cloud3.physicsBody.sensor = true; cloud4.physicsBody.sensor = true
        cloud1.physicsBody.velocity = cloudVel; cloud2.physicsBody.velocity = cloudVel; cloud3.physicsBody.velocity = cloudVel; cloud4.physicsBody.velocity = cloudVel
        
        if startLoc.positionType.corner == .TopRight {
            mathPos = CGPointMake(UIScreen.mainScreen().bounds.width - startLoc.position.x, UIScreen.mainScreen().bounds.height - startLoc.position.y)
        } else if startLoc.positionType.corner == .BottomRight {
            mathPos = CGPointMake(UIScreen.mainScreen().bounds.width - startLoc.position.x, startLoc.position.y)
        } else if startLoc.positionType.corner == .TopLeft {
            mathPos = CGPointMake(startLoc.position.x ,UIScreen.mainScreen().bounds.height - startLoc.position.y)
        } else {
            mathPos = startLoc.position
        }
        
        character.position = mathPos
        


    }
    
    
// Flag Collision Function //
    
    func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair!, character: CCSprite!, goal: CCSprite!) -> ObjCBool{
        if !isGameOver {
            levelComplete()
        }
        return true
    }
    
    
// Level Finished Function //
    
    func levelComplete() {
        let state = UserState()
        
        if !isNewBall{
            character.visible = false
        } else {
            characterMini.visible = false
        }
        isGameOver = true
        let fadeIn = CCActionFadeIn(duration: 1.0)

        distanceUsed = Int(disUsed)
        
        // Make Character Sparkle //
        
        if !sparkleBool {
            makeSparkle()
            sparkleBool = true
        }
        
        // Load Recap Screen //

        let recapScreen = CCBReader.load("Recap", owner: self) as! Recap
        recapScreen.name = "recap"
        recapScreen.position = (midScreen)
        recapScreen.linesLabel.string = toString(distanceUsed)
        recapScreen.levelNumLabel.string = toString(levelNum)
        addChild(recapScreen)
        
        // Star Animations //
        var starRay = state.starArray
     
        halfStar = star1.contentSize.width/2
        
        scheduleBlock({ (time) -> Void in
            if self.distanceUsed <= self.onestar {
                recapScreen.animationManager.runAnimationsForSequenceNamed("shineStar3")
                if starRay[levelNum] < 3 {
                    starRay[levelNum] = 3
                    state.starArray = starRay
                }
            } else if self.distanceUsed <= self.twostar {
                recapScreen.animationManager.runAnimationsForSequenceNamed("shineStar2")
                if starRay[levelNum] < 2 {
                    starRay[levelNum] = 2
                    state.starArray = starRay
                }
            } else {recapScreen.animationManager.runAnimationsForSequenceNamed("shineStar1")
                if starRay[levelNum] < 1 {
                    starRay[levelNum] = 1 }
                    state.starArray = starRay
                }
            if levelNum != 24 && levelNum != 48 && levelNum != 72 {
                self.backButton.visible = true
            }
            levelNum++
            
            // Increase unlocked level
            var unlockedLevel = state.unlockedLevel
            var totalStars: Int = 0
            for var x = 0; x < starRay.count; x++ {
                totalStars += starRay[x]
            }
            if totalStars >= 45 {
                state.unlockWorld1 = true
            }
            if totalStars >= 90 {
                state.unlockWorld2 = true
            }
            
            if levelNum > unlockedLevel {
                state.unlockedLevel = levelNum
            }
            
            // Unlock new skins
            
            if totalStars >= 20 {
                state.unlockSkin1 = true
            }
            if totalStars >= 40 {
                state.unlockSkin2 = true
            }
            if totalStars >= 60 {
                state.unlockSkin3 = true
            }
            if totalStars >= 80 {
                state.unlockSkin4 = true
            }
            if totalStars >= 100 {
                state.unlockSkin5 = true
            }

        }, delay: 1.5 )
        
        if !isChange {
            character.physicsBody.velocity = ccp(0, 0)
            
        } else {
            characterMini.physicsBody.velocity = ccp(0, 0)
            
        }
        
    }
    
    func makeSparkle() {
        let sparkle = CCBReader.load("Sparkle") as! CCParticleSystem
        sparkle.autoRemoveOnFinish = true
        if !isChange {
        sparkle.position = character.position
        } else { sparkle.position=characterMini.position }
        addChild(sparkle)
        
    }
    
    
// Touch Began Function //
    
    override func touchBegan(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        if !isGameOver {
            location = touch.locationInWorld()
            
             if !isAnim && !isGamePaused {
                dragNode1.visible = true
                dragNode2.visible = true
            }
           
            let firstLocation = touch.locationInNode(self)
            dragNode1.position = firstLocation
            dragNode2.position = firstLocation
        }
    }
    
    
// Touch Moved Function //
    
    override func touchMoved(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        if !isGameOver && !isGamePaused{
            let touchLocation = touch.locationInNode(self)
            dragNode2.position = touchLocation
            
            
            
            if dragNode1.visible == true && ccpDistance(dragNode2.position, dragNode1.position) > 20{
                var xDis = (dragNode2.position.x - dragNode1.position.x)/2
                var yDis = (dragNode2.position.y - dragNode1.position.y)/2
                var xPos = dragNode2.position.x - xDis
                var yPos = dragNode2.position.y - yDis
                var xDisDouble: Double = Double(xDis)
                var yDisDouble: Double = Double(yDis)
                var nodeDis = ccpDistance(dragNode1.position, dragNode2.position)
                scaleFactor = Float(nodeDis) / 10.0
                let angle: Double = atan(yDisDouble/xDisDouble) * -180 / M_PI
                let angleFloat = Float(angle)
                var midNode: CGPoint = CGPointMake(xPos, yPos)
                pathOutline.position = CGPointMake(xPos, yPos)
                pathOutline.scaleX = (scaleFactor)
                pathOutline.rotation = angleFloat
                pathOutline.visible = true
            }
        }
    }
    
    
// Touch Ended Function //
    
    override func touchEnded(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        if ball1 != nil{
            isLineIntersectBall = lineBalls()
        }
       
        if !isGameOver && !isAnim && !isGamePaused{
            
            pathOutline.visible = false
            
        
            location2 = touch.locationInWorld()
            var intersect: Bool
           
            if noDrawNode != nil {
                    let isNode = lineIntersectNode()
                   
                    if !isNode && !isLineIntersectBall {
                        length = ccpDistance(location, location2)
                        
                        if !isNewBall {
                            intersect = lineIntersectBall()
                        } else {
                            intersect = lineIntersectBall2()
                        }
                        if length > 15 && !intersect {
                           
                            makePlatform()
                            dragNode1.visible = false
                            dragNode2.visible = false
                        } else if length < 15 || intersect{
                            dragNode1.color = CCColor.redColor()
                            dragNode2.color = CCColor.redColor()
                            scheduleBlock({ (time) -> Void in
                                self.dragNode1.visible = false
                                self.dragNode2.visible = false
                                self.dragNode1.color = self.dragColor
                                self.dragNode2.color = self.dragColor
                            }, delay: 0.2)
                     
                        } else { }
                    } else if isNode || isLineIntersectBall{
                        dragNode1.color = CCColor.redColor()
                        dragNode2.color = CCColor.redColor()
                        scheduleBlock({ (time) -> Void in
                            self.dragNode1.visible = false
                            self.dragNode2.visible = false
                            self.dragNode1.color = self.dragColor
                            self.dragNode2.color = self.dragColor
                        }, delay: 0.2)
                        }
                    } else{
                        length = ccpDistance(location, location2)
                
                        if !isNewBall {
                            intersect = lineIntersectBall()
                        } else {
                            intersect = lineIntersectBall2()
                        }
                        if length > 15 && !intersect {
                          
                            makePlatform()
                            dragNode1.visible = false
                            dragNode2.visible = false
                        } else if length < 15 || intersect{
                            dragNode1.color = CCColor.redColor()
                            dragNode2.color = CCColor.redColor()
                            scheduleBlock({ (time) -> Void in
                                self.dragNode1.visible = false
                                self.dragNode2.visible = false
                                self.dragNode1.color = self.dragColor
                                self.dragNode2.color = self.dragColor
                            }, delay: 0.2)
                        } else { }
                    
                    }
            
        }
        
        
       isLineIntersectBall = false
    }
    
    
// Make Platform Function //
    
  func makePlatform() {
    
    var xDis = (dragNode2.position.x - dragNode1.position.x)/2
    var yDis = (dragNode2.position.y - dragNode1.position.y)/2
    var xPos = dragNode2.position.x - xDis
    var yPos = dragNode2.position.y - yDis
    var xDisDouble: Double = Double(xDis)
    var yDisDouble: Double = Double(yDis)
    var nodeDis = ccpDistance(dragNode1.position, dragNode2.position)
    scaleFactor = Float(nodeDis) / 10.0
    let angle: Double = atan(yDisDouble/xDisDouble) * -180 / M_PI
    let angleFloat = Float(angle)
    var midNode: CGPoint = CGPointMake(xPos, yPos)
    platform = CCBReader.load("Platform") as! CCSprite
    platform.position = CGPointMake(xPos, yPos)
    platform.scaleX = (scaleFactor)
    platform.rotation = angleFloat
    if angleFloat.isFinite{
        gamePhysicsNode.addChild(platform)
        platformArray.append(platform)
        disUsed = disUsed + nodeDis
    }
    }
    
    
// Node Intersection Function //
    
    func lineIntersectNode() -> Bool {
        let diff = ccpSub(location2, location)
        let seg = ccpMult(diff, 0.1)
        if CGRectContainsPoint(noDrawNode.boundingBox(), location){
            return true
        }
        if CGRectContainsPoint(noDrawNode.boundingBox(), location2){
            return true
        }
        
        var loc = location
        for var num = 0; num<10; num++ {
            loc = ccpAdd(seg, loc)
            if CGRectContainsPoint(noDrawNode.boundingBox(), loc){
                return true
            }
        }
        return false
        
    }

    
// Ball Intersection Function //
    
    func lineIntersectBall() -> Bool {
        let diff = ccpSub(location2, location)
        let seg = ccpMult(diff, 0.04)
       
        if CGRectContainsPoint(charLocator.boundingBox(), location){
            return true
        }
        if CGRectContainsPoint(charLocator.boundingBox(), location2){
            return true
        }

        var loc = location
        for var num = 0; num<25; num++ {
            loc = ccpAdd(seg, loc)
            if CGRectContainsPoint(charLocator.boundingBox(), loc){
                return true
            }
        }
       return false
        
    }
    
    func lineIntersectBall2() -> Bool {
        let diff = ccpSub(location2, location)
        let seg = ccpMult(diff, 0.02)
        if CGRectContainsPoint(flingNode.boundingBox(), location){
            return true
        }
        if CGRectContainsPoint(flingNode.boundingBox(), location2){
            return true
        }
        var loc = location
        for var num = 0; num<50; num++ {
            loc = ccpAdd(seg, loc)
            if CGRectContainsPoint(flingNode.boundingBox(), loc){
                return true
            }
        }
        return false
        
    }

    func lineBalls() -> Bool {
        if numBalls == 1 {
            let diff = ccpSub(dragNode2.position, location)
            let seg = ccpMult(diff, 0.05)
            if CGRectContainsPoint(ballLocator.boundingBox(), location){
                return true
            }
            if CGRectContainsPoint(ballLocator.boundingBox(), dragNode2.position){
                return true
            }
            var loc = location
            for var num = 0; num<20; num++ {
                loc = ccpAdd(seg, loc)
                if CGRectContainsPoint(ballLocator.boundingBox(), loc){
                    return true
                }
            }
        }
        if numBalls == 2 {
            let diff = ccpSub(dragNode2.position, location)
            let seg = ccpMult(diff, 0.05)
            if CGRectContainsPoint(ballLocator.boundingBox(), location) || CGRectContainsPoint(ballLocator2.boundingBox(), location){
                return true
            }
            if CGRectContainsPoint(ballLocator.boundingBox(), dragNode2.position) || CGRectContainsPoint(ballLocator2.boundingBox(), dragNode2.position){
                return true
            }
            var loc = location
            for var num = 0; num<20; num++ {
                loc = ccpAdd(seg, loc)
                if CGRectContainsPoint(ballLocator.boundingBox(), loc) || CGRectContainsPoint(ballLocator2.boundingBox(), loc){
                    return true
                }
            }

        }
        return false

    }
    
// Key Collison //
    
    func ccPhysicsCollisionPostSolve(pair: CCPhysicsCollisionPair!, character: CCSprite!, key: Key!) {
        key.physicsBody.sensor = true
       
        keyTouched()
        
    }

    func keyTouched() {
        // Find Key Position
        
        if keyLoc.positionType.corner == .BottomRight{
                keyPos = CGPointMake(UIScreen.mainScreen().bounds.width - keyLoc.position.x, keyLoc.position.y)
        } else if keyLoc.positionType.corner == .TopRight{
                keyPos = CGPointMake(UIScreen.mainScreen().bounds.width - keyLoc.position.x, UIScreen.mainScreen().bounds.height - keyLoc.position.y)
        } else if keyLoc.positionType.corner == .TopLeft{
            keyPos = CGPointMake(keyLoc.position.x, UIScreen.mainScreen().bounds.height - keyLoc.position.y)
        } else {
            keyPos = keyLoc.position
        }
        
        key.positionType.corner = .BottomLeft
        
        // Find Gate Position
        
        if gateLoc.positionType.corner == .BottomRight{
                gatePos = CGPointMake(UIScreen.mainScreen().bounds.width - gateLoc.position.x, gateLoc.position.y) }
        else if gateLoc.positionType.corner == .TopRight{
                gatePos = CGPointMake(UIScreen.mainScreen().bounds.width - gateLoc.position.x, UIScreen.mainScreen().bounds.height - gateLoc.position.y)
        } else if gateLoc.positionType.corner == .TopLeft{
            gatePos = CGPointMake(gateLoc.position.x, UIScreen.mainScreen().bounds.height - gateLoc.position.y)
        } else {
            gatePos = gateLoc.position
        }
        
        if !isGateOpen{
            let pointX: CGFloat = CGFloat(level.gateX)
            let pointY: CGFloat = CGFloat(level.gateY)
            point = CGPointMake(pointX, pointY)
            isGateOpen = true
            scheduleBlock({ (time) -> Void in
                self.isKeyMove = false
                 }, delay: 1.05)
            isKeyMove = true
            
            key.animate(gatePos)
           
        }
            scheduleBlock({ (time) -> Void in
                if self.isKeyMove{
                    self.gate.animate(self.point)
                }
            }, delay: 1.0)
        
 
        }

    
// Spike Collision Functions //
    
    func ccPhysicsCollisionPostSolve(pair: CCPhysicsCollisionPair!, character: CCSprite!, spike: Spike!) {
        spikeTouched()
        
    }
    
    func spikeTouched() {
        let ouchNode = CCBReader.load("Ouch")
        self.addChild(ouchNode)
        if !isNewBall{
            character.physicsBody.angularVelocity = 0
            character.physicsBody.velocity = ccp(0, 0)
            character.position = mathPos
        } else {
            characterMini.physicsBody.angularVelocity = 0
            characterMini.physicsBody.velocity = ccp(0, 0)
            characterMini.position = mathPos

        }
        scheduleBlock({ (time) -> Void in
            if self.isGateOpen && self.isKeyMove{
                self.key.stopAllActions()
                self.key.position = self.keyPos
                self.isKeyMove = false
                self.gate.stopAllActions()
                self.moveGateBack()
                self.isGateOpen = false
                self.key.physicsBody.sensor = false
                self.key.opacity = 1.0
            }
            
            if self.isGateOpen && !self.isKeyMove{
                self.key.stopAllActions()
                self.key.position = self.keyPos
                self.key.physicsBody.sensor = false
                self.gate.stopAllActions()
                self.moveGateBack()
                self.key.opacity = 1.0
                self.isGateOpen = false

            }
        }, delay: 0.05)


    }
    
// Move Back Gate Function //
    
    func moveGateBack() {
        if gate.positionType.corner == .TopRight {
            let backLoc = CGPointMake(UIScreen.mainScreen().bounds.width - gatePos.x, UIScreen.mainScreen().bounds.height - gatePos.y)
            let moveBackGate = CCActionMoveTo(duration: 0.25, position: backLoc)
            gate.stopAllActions()
            gate.runAction(moveBackGate)
        } else if gate.positionType.corner == .TopLeft {
            let backLoc = CGPointMake(gatePos.x, UIScreen.mainScreen().bounds.height - gatePos.y)
            let moveBackGate = CCActionMoveTo(duration: 0.25, position: backLoc)
            gate.stopAllActions()
            gate.runAction(moveBackGate)
        } else if gate.positionType.corner == .BottomRight {
            let backLoc = CGPointMake(UIScreen.mainScreen().bounds.width - gatePos.x, gatePos.y)
            let moveBackGate = CCActionMoveTo(duration: 0.25, position: backLoc)
            gate.stopAllActions()
            gate.runAction(moveBackGate)
        } else {
            let moveBackGate = CCActionMoveTo(duration: 0.25, position: gatePos)
            gate.stopAllActions()
            gate.runAction(moveBackGate)
        }

    }
    
// Jump Functions //
    
    func ccPhysicsCollisionPostSolve(pair: CCPhysicsCollisionPair!, character: CCSprite!, jump: Jump!) {
        if isJump{
            
            jumpNode = CCBReader.load("Jump") as! Jump
            jumpNode.position = jumpPos
            level.addChild(jumpNode)
            if jump.positionType.corner == .TopRight{
                jumpPos = CGPointMake(UIScreen.mainScreen().bounds.width - jump.position.x, UIScreen.mainScreen().bounds.height - jump.position.y)
            } else if jump.positionType.corner == .BottomRight{
                jumpPos = CGPointMake(UIScreen.mainScreen().bounds.width - jump.position.x, jump.position.y)
            } else if jump.positionType.corner == .TopLeft {
                jumpPos = CGPointMake(jump.position.x, UIScreen.mainScreen().bounds.height - jump.position.y)
            } else {
                jumpPos = jump.position
            }
            jump.animate()
            

        }
        
        if !jumpTouched {
        jumpTouched = true
        jumpButton.opacity = 0
            
            // Find jump position
            
            if jump.positionType.corner == .TopRight{
                jumpPos = CGPointMake(UIScreen.mainScreen().bounds.width - jump.position.x, UIScreen.mainScreen().bounds.height - jump.position.y)
            } else if jump.positionType.corner == .BottomRight{
                jumpPos = CGPointMake(UIScreen.mainScreen().bounds.width - jump.position.x, jump.position.y)
            } else if jump.positionType.corner == .TopLeft {
                jumpPos = CGPointMake(jump.position.x, UIScreen.mainScreen().bounds.height - jump.position.y)
            } else {
                jumpPos = jump.position
            }
            
            // Jump particle
            
            let jumpSpark = CCBReader.load("jumpParticle") as! CCParticleSystem
            jumpSpark.autoRemoveOnFinish = true
            jumpSpark.position = jumpPos
            let upPosition = CGPointMake(UIScreen.mainScreen().bounds.width - upPicture.position.x, UIScreen.mainScreen().bounds.height - upPicture.position.y)
            let moveSpark = CCActionMoveTo(duration: 0.8, position: upPosition)
            level.addChild(jumpSpark)
            jumpSpark.runAction(moveSpark)
            
        jump.animate()
        jumpNode = jump
        jumpNode2 = jump
        let fadedIn = CCActionFadeIn(duration: 0.6)
        scheduleBlock({ (time) -> Void in
            self.isJump = true
            
            self.jumpButton.visible = true
            self.upPicture.runAction(fadedIn)
            
            }, delay: 0.5)
        }
    }
    
    func jumpBall() {
        if !isGameOver && !isGamePaused && !isAnim {
            if !isNewBall {
                character.physicsBody.applyImpulse(jumpPoint)
            } else {
                characterMini.physicsBody.applyImpulse(jumpPoint2)
            }
            upPicture.stopAllActions()
            upPicture.opacity = 0.0
            jumpButton.visible = false
            getBack()
        }
    }
    
    func getBack(){
        if isJump{
            scheduleBlock({ (time) -> Void in
                self.jumpNode = CCBReader.load("Jump") as! Jump
                self.jumpNode.position = self.jumpPos
                self.level.addChild(self.jumpNode)
                self.isJump = false
                self.jumpTouched = false
            }, delay: 0.5)
        }
    }

    
// Potion Collision Functions //
    
    func ccPhysicsCollisionPostSolve(pair: CCPhysicsCollisionPair!, character: CCSprite!, potion: Potion!) {
        potionTouched()
    }
    
    func potionTouched() {
         isAnim = true
        scheduleBlock({ (time) -> Void in
            self.isAnim = false
        }, delay: 1.1)
        
        character.physicsBody.angularVelocity = 0.0
        let rotateAnim = CCActionRotateBy(duration: 0, angle: character.rotation)
        let state = UserState()
        if state.skinNum == 0 {
            charAnim = CCBReader.load("charAnim") as CCNode
            characterMini = CCBReader.load("Char2") as! CCSprite
        } else if state.skinNum == 1 {
            charAnim = CCBReader.load("charAnimB") as CCNode
            characterMini = CCBReader.load("Char2B") as! CCSprite
        } else if state.skinNum == 2 {
            charAnim = CCBReader.load("charAnimC") as CCNode
            characterMini = CCBReader.load("Char2C") as! CCSprite
        } else if state.skinNum == 3  {
            charAnim = CCBReader.load("charAnimD") as CCNode
            characterMini = CCBReader.load("Char2D") as! CCSprite
        } else if state.skinNum == 4 {
            charAnim = CCBReader.load("charAnimE") as CCNode
            characterMini = CCBReader.load("Char2E") as! CCSprite
        } else {
            charAnim = CCBReader.load("charAnimF") as CCNode
            characterMini = CCBReader.load("Char2F") as! CCSprite
        }
        charAnim.position = character.position
        charAnim.runAction(rotateAnim)
        self.addChild(charAnim)
        scheduleBlock({ (time) -> Void in
           self.charAnim.removeFromParent()
            }, delay: 1.0)
        characterMini.position = character.position
        characterMini.physicsBody.type = .Static
        characterMini.physicsBody.collisionType = "character"
        isChange = true
        characterMini.runAction(rotateAnim)
        character.visible = false
        character.physicsBody.sensor = true
        character.physicsBody.affectedByGravity = false
        character.physicsBody.type = .Static
        gamePhysicsNode.addChild(characterMini)
        scheduleBlock({ (time) -> Void in
            self.characterMini.physicsBody.type = .Dynamic
            self.isNewBall = true
            }, delay: 1.0)

        if !isPotion {
            isPotion = true
            potion.animate()
            
        }
    }
    
// Star Shine Functions //
    
    func shiner1() {
        let shiny = CCBReader.load("StarParticle") as! CCParticleSystem
        shiny.autoRemoveOnFinish = true
        shiny.position = CGPointMake(halfStar, halfStar)
        star1.addChild(shiny)
        
    }

    func shiner2() {
        let shiny = CCBReader.load("StarParticle") as! CCParticleSystem
        shiny.autoRemoveOnFinish = true
        shiny.position = CGPointMake(halfStar, halfStar)
        star2.addChild(shiny)
    }
    
    func shiner3() {
        let shiny = CCBReader.load("StarParticle") as! CCParticleSystem
        shiny.autoRemoveOnFinish = true
        shiny.position = CGPointMake(halfStar, halfStar)
        star3.addChild(shiny)
    }
    
// Button Functions //
    
    
    func back() {
        let menu = CCBReader.loadAsScene("MainScene")
        CCDirector.sharedDirector().replaceScene(menu)
    }

    func undo() {
        if !isGameOver && !isGamePaused{
            if platformArray.count >= 1 {
                let platformToDelete = platformArray[platformArray.count - 1]
                platformArray.removeAtIndex(platformArray.count-1)
                gamePhysicsNode.removeChild(platformToDelete)
            }
        }
    }
    
    func clearLines(){
        if !isGameOver {
            for var x = 0; x<platformArray.count; x++ {
                let platformToDelete = platformArray[x]
                
                gamePhysicsNode.removeChild(platformToDelete)
            }
            platformArray.removeAll()
        }
    }
    
    func pause(){
        
        if !isGamePaused && !isGameOver{
            if !isNewBall{
                pauseVelocity = character.physicsBody.velocity
            } else {
               pauseVelocity = characterMini.physicsBody.velocity
            }
            gamePhysicsNode.paused = true
            motionManager.stopAccelerometerUpdates()
            backButton.visible = true
            
            isGamePaused = true
            lvlLabel.string = ("\(levelNum)")
            lvlLabel.visible = true
            lvlText.visible = true
            recordTxt.visible = true
            pausePic = CCBReader.load("Pause") as! CCSprite
            pausePic.scale = 2
            pausePic.position = midScreen
            pauseButt.selected = true
            
            self.addChild(pausePic)
            let state = UserState()
            let starRay = state.starArray
            if starRay[levelNum] == 1{
                starNum1.visible = true
            }
            if starRay[levelNum] == 2{
                starNum1.visible = true
                starNum2.visible = true
            }
            if starRay[levelNum] == 3{
                starNum1.visible = true
                starNum2.visible = true
                starNum3.visible = true
            }
        } else {
            if !isGameOver {
                self.removeChild(pausePic)
                starNum1.visible = false
                starNum2.visible = false
                starNum3.visible = false
                motionManager.startAccelerometerUpdates()
                lvlLabel.visible = false
                
                lvlText.visible = false
                recordTxt.visible = false
                isGamePaused = false
                pauseButt.selected = false
                backButton.visible = false
                gamePhysicsNode.paused = false
                if !isNewBall{
                    character.physicsBody.velocity = pauseVelocity
                } else {
                    characterMini.physicsBody.velocity = pauseVelocity
                }
            }

        }
    }
    
    func nextLevel() {
        if levelNum == 25 || levelNum == 49 || levelNum == 73 {
            let menu = CCBReader.loadAsScene("MainScene")
            CCDirector.sharedDirector().replaceScene(menu)
        } else {
        var nextName = ("Levels/Level\(levelNum)")
        let nextlevel = CCBReader.load(nextName, owner: self) as! Level
        disUsed = 0
        for var x = 0; x<platformArray.count; x++ {
            let platformToDelete = platformArray[x]
            gamePhysicsNode.removeChild(platformToDelete)
        }
        platformArray.removeAll()
        isGameOver = false
        self.removeChildByName("recap")
        backButton.visible = false
        level.removeFromParent()
        isGateOpen = false
        sparkleBool = false
        isChange = false
        isPotion = false
        isLineIntersectBall = false

        if isNewBall{
            isNewBall = false
            characterMini.removeFromParent()
        }
        character.visible = true
        character.physicsBody.sensor = false
        character.physicsBody.type = .Dynamic
        character.physicsBody.affectedByGravity = true
        
        level = nextlevel
        onestar = level.onestar
        twostar = level.twostar
        numBalls = level.numBalls
        startLoc = level.getChildByName("startLocation", recursively: true)
        if startLoc.positionType.corner == .TopRight {
            mathPos = CGPointMake(UIScreen.mainScreen().bounds.width - startLoc.position.x, UIScreen.mainScreen().bounds.height - startLoc.position.y)
        } else if startLoc.positionType.corner == .BottomRight {
            mathPos = CGPointMake(UIScreen.mainScreen().bounds.width - startLoc.position.x, startLoc.position.y)
        } else if startLoc.positionType.corner == .TopLeft {
            mathPos = CGPointMake(startLoc.position.x ,UIScreen.mainScreen().bounds.height - startLoc.position.y)
        } else {
            mathPos = startLoc.position
        }
        character.position = mathPos
        character.physicsBody.velocity = ccp(0, 0)
        character.physicsBody.angularVelocity = 0.0
        gamePhysicsNode.addChild(nextlevel)
        noDrawNode = self.getChildByName("noDrawNode", recursively: true)
        if numBalls == 1 {
            ball1 = getChildByName("ball1", recursively: true) as! CCSprite
            if ball1.positionType.corner == .TopRight {
                ball1Loc = CGPointMake(UIScreen.mainScreen().bounds.width - ball1.position.x, UIScreen.mainScreen().bounds.height - ball1.position.y)
            } else if ball1.positionType.corner == .BottomRight {
                ball1Loc = CGPointMake(UIScreen.mainScreen().bounds.width - ball1.position.x, ball1.position.y)
            } else if ball1.positionType.corner == .TopLeft {
                
                ball1Loc = CGPointMake(ball1.position.x, UIScreen.mainScreen().bounds.height - ball1.position.y)
            } else {
                ball1Loc = ball1.position
            }
            ball1.positionType.corner = .BottomLeft
            ball1.position = ball1Loc
            ballLocator.scale = Float(ball1.contentSize.height / 5.0)
        }
        if numBalls == 2 {
            ball1 = getChildByName("ball1", recursively: true) as! CCSprite
            ball2 = getChildByName("ball2", recursively: true) as! CCSprite
            if ball1.positionType.corner == .TopRight {
                ball1Loc = CGPointMake(UIScreen.mainScreen().bounds.width - ball1.position.x, UIScreen.mainScreen().bounds.height - ball1.position.y)
            } else if ball1.positionType.corner == .BottomRight {
                ball1Loc = CGPointMake(UIScreen.mainScreen().bounds.width - ball1.position.x, ball1.position.y)
            } else if ball1.positionType.corner == .TopLeft {
                
                ball1Loc = CGPointMake(ball1.position.x, UIScreen.mainScreen().bounds.height - ball1.position.y)
            } else {
                ball1Loc = ball1.position
            }
            
            
            if ball2.positionType.corner == .TopRight {
                ball2Loc = CGPointMake(UIScreen.mainScreen().bounds.width - ball2.position.x, UIScreen.mainScreen().bounds.height - ball2.position.y)
            } else if ball2.positionType.corner == .BottomRight {
                ball2Loc = CGPointMake(UIScreen.mainScreen().bounds.width - ball2.position.x, ball2.position.y)
            } else if ball2.positionType.corner == .TopLeft {
                
                ball2Loc = CGPointMake(ball2.position.x, UIScreen.mainScreen().bounds.height - ball2.position.y)
            } else {
                ball2Loc = ball2.position
            }
            ballLocator.scale = Float(ball1.contentSize.height / 5.0)
            ballLocator2.scale = Float(ball2.contentSize.height / 5.0)
            ball1.positionType.corner = .BottomLeft
            ball1.position = ball1Loc
            ball2.positionType.corner = .BottomLeft
            ball2.position = ball2Loc

        }
        }
        
    }
    
    func hideButtons() {
        if !isHidden {
            let upMove = CCActionMoveBy(duration: 0.5, position: CGPoint(x: 0, y: -50))
            buttonsNode.runAction(upMove)
            isHidden = true
        } else {
            let downMove = CCActionMoveBy(duration: 0.5, position: CGPoint(x: 0, y: 50))
                buttonsNode.runAction(downMove)
            isHidden = false
        }
    }
    
    func reset() {
        if !isGameOver && !isAnim && !isGamePaused && !isGateOpen{
            
            let ouchNode = CCBReader.load("Ouch")
            self.addChild(ouchNode)
            
            if !isNewBall{
            character.physicsBody.angularVelocity = 0
            character.physicsBody.velocity = (ccp(0, 0))
            character.position = mathPos
            } else {
                characterMini.physicsBody.angularVelocity = 0
                characterMini.physicsBody.velocity = (ccp(0, 0))
                characterMini.position = mathPos
            }
            if numBalls == 1 {
                ball1.positionType.corner = .BottomLeft
                ball1.position = ball1Loc
                ball1.physicsBody.velocity = ccp(0, 0)
                ball1.physicsBody.angularVelocity = 0.0
            }
            if numBalls == 2 {
                ball1.positionType.corner = .BottomLeft
                ball2.positionType.corner = .BottomLeft
                ball2.position = ball2Loc
                ball2.physicsBody.velocity = ccp(0, 0)
                ball2.physicsBody.angularVelocity = 0.0
                ball1.position = ball1Loc
                ball1.physicsBody.angularVelocity = 0.0
                ball1.physicsBody.velocity = ccp(0, 0)
            }
        }
        
        if isGateOpen && !isGamePaused && !isGameOver{
            if isKeyMove{
                
                key.stopAllActions()
                gate.stopAllActions()
                key.opacity = 1.0
                
                key.position = keyPos
                isKeyMove = false
                isGateOpen = false
                if !isNewBall {
                    character.physicsBody.angularVelocity = 0
                    character.physicsBody.velocity = (ccp(0, 0))
                    character.position = mathPos
                } else {
                    characterMini.physicsBody.angularVelocity = 0
                    characterMini.physicsBody.velocity = (ccp(0, 0))
                    characterMini.position = mathPos
                }

                scheduleBlock({ (time) -> Void in
                    self.key.physicsBody.sensor = false
                 }, delay: 0.25)
                
            } else {
                if !isNewBall{
                    character.physicsBody.angularVelocity = 0
                    character.physicsBody.velocity = (ccp(0, 0))
                    character.position = mathPos
                    
                } else {
                    characterMini.physicsBody.angularVelocity = 0
                    characterMini.physicsBody.velocity = (ccp(0, 0))
                    characterMini.position = mathPos
                }
                moveGateBack()
                key.opacity = 1.0
                key.position = keyPos
                key.physicsBody.sensor = false
                let fadeIn = CCActionFadeIn(duration: 0.5)
                key.runAction(fadeIn)
                isKeyMove = false
                isGateOpen = false
            }
        }
    }
   
}

