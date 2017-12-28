//
//  LevelObstacles.swift
//  An Endless Run
//
//  Created by Noah Hanover on 4/22/16.
//  Copyright © 2016 Noah Hanover. All rights reserved.
//

import SpriteKit

class LevelCreator {
    var win_level: SKShapeNode! = nil
    let REDENEMY_BITMASK: UInt32 = 3
    let DOOR_BITMASK: UInt32 = 2
    let BOUNCE_YELLOW: UInt32 = 4
    
    func initialize_door() {
        win_level = SKShapeNode(rectOfSize: CGSizeMake(40, 60))
        win_level.name = "door"
        win_level.fillColor = SKColor.blackColor()
        win_level.strokeColor = SKColor.whiteColor()
        win_level.physicsBody = SKPhysicsBody.init(rectangleOfSize: win_level.frame.size)
        win_level.physicsBody?.dynamic = false
        win_level.physicsBody?.collisionBitMask = DOOR_BITMASK
        win_level.physicsBody?.contactTestBitMask = (win_level.physicsBody?.collisionBitMask)!
    }
    
    func createLevel1(world: SKNode, width: CGFloat) {
        let first_obstacle = SKShapeNode(rectOfSize: CGSize(width: 100, height: 100))
        first_obstacle.fillColor = SKColor.grayColor()
        first_obstacle.position = CGPointMake(width/2, 150)
        first_obstacle.strokeColor = SKColor.clearColor()
        first_obstacle.physicsBody = SKPhysicsBody.init(rectangleOfSize: first_obstacle.frame.size)
        first_obstacle.physicsBody?.dynamic = false
        first_obstacle.physicsBody?.restitution = 0
        world.addChild(first_obstacle)
        
        win_level.position = CGPointMake(width-30, 130)
        world.addChild(win_level)
    }
    
    func createLevel2(world: SKNode) {
        let first_obstacle = SKShapeNode(rectOfSize: CGSize(width: 70, height: 10))
        first_obstacle.fillColor = SKColor.grayColor()
        first_obstacle.position = CGPointMake(230, 190)
        first_obstacle.strokeColor = SKColor.clearColor()
        first_obstacle.physicsBody = SKPhysicsBody.init(rectangleOfSize: first_obstacle.frame.size)
        first_obstacle.physicsBody?.dynamic = false
        first_obstacle.physicsBody?.restitution = 0
        world.addChild(first_obstacle)
        
        let red_enemy = SKShapeNode(rectOfSize: CGSize(width: 300, height: 5))
        red_enemy.fillColor = SKColor.redColor()
        red_enemy.position = CGPointMake(270, 100)
        red_enemy.strokeColor = SKColor.clearColor()
        red_enemy.physicsBody = SKPhysicsBody.init(rectangleOfSize: red_enemy.frame.size)
        red_enemy.physicsBody?.collisionBitMask = REDENEMY_BITMASK
        red_enemy.physicsBody?.contactTestBitMask = (red_enemy.physicsBody?.collisionBitMask)!
        red_enemy.physicsBody?.dynamic = false
        world.addChild(red_enemy)
        
        let door_platform = SKShapeNode(rectOfSize: CGSize(width: 70, height: 10))
        door_platform.fillColor = SKColor.grayColor()
        door_platform.position = CGPointMake(100, 330)
        door_platform.strokeColor = SKColor.clearColor()
        door_platform.name = "door_platform2"
        door_platform.physicsBody = SKPhysicsBody.init(rectangleOfSize: door_platform.frame.size)
        door_platform.physicsBody?.dynamic = false
        door_platform.physicsBody?.restitution = 0
        world.addChild(door_platform)
        
        win_level.position = CGPointMake(100, 365)
        world.addChild(win_level)
    }
    
    func createLevel3(world: SKNode, width: CGFloat) {
        let red_circle = SKShapeNode(circleOfRadius: 30)
        red_circle.fillColor = SKColor.redColor()
        red_circle.strokeColor = SKColor.clearColor()
        red_circle.physicsBody = SKPhysicsBody.init(circleOfRadius: 30)
        red_circle.physicsBody?.collisionBitMask = REDENEMY_BITMASK
        red_circle.physicsBody?.contactTestBitMask = (red_circle.physicsBody?.collisionBitMask)!
        red_circle.physicsBody?.dynamic = false
        red_circle.position = CGPointMake(150, 140)
        red_circle.runAction(SKAction.repeatActionForever(SKAction.sequence([SKAction.moveTo(CGPointMake(width-70, 140), duration: 1), SKAction.moveTo(CGPointMake(150, 140), duration: 1)])))
        world.addChild(red_circle)
        
        let elevator_platform = SKShapeNode(rectOfSize: CGSize(width: 70, height: 10))
        elevator_platform.fillColor = SKColor.grayColor()
        elevator_platform.strokeColor = SKColor.clearColor()
        elevator_platform.physicsBody = SKPhysicsBody.init(rectangleOfSize: elevator_platform.frame.size)
        elevator_platform.physicsBody?.dynamic = false
        elevator_platform.physicsBody?.restitution = 0
        elevator_platform.position = CGPointMake(230, 200)
        elevator_platform.runAction(SKAction.repeatActionForever(SKAction.sequence([SKAction.moveTo(CGPointMake(230, 340), duration: 1), SKAction.moveTo(CGPointMake(230, 200), duration: 1)])))
        world.addChild(elevator_platform)
        
        let door_platform = SKShapeNode(rectOfSize: CGSize(width: 70, height: 10))
        door_platform.fillColor = SKColor.grayColor()
        door_platform.position = CGPointMake(50, 415)
        door_platform.strokeColor = SKColor.clearColor()
        door_platform.name = "door_platform2"
        door_platform.physicsBody = SKPhysicsBody.init(rectangleOfSize: door_platform.frame.size)
        door_platform.physicsBody?.dynamic = false
        door_platform.physicsBody?.restitution = 0
        world.addChild(door_platform)
        
        win_level.position = CGPointMake(50, 450)
        world.addChild(win_level)
    }
    
    func createLevel4(world: SKNode, width: CGFloat) {
        let first_bounce = SKShapeNode(circleOfRadius: 50)
        first_bounce.zPosition = 1
        first_bounce.fillColor = SKColor.yellowColor()
        first_bounce.strokeColor = SKColor.clearColor()
        first_bounce.physicsBody = SKPhysicsBody.init(circleOfRadius: 50)
        first_bounce.physicsBody?.collisionBitMask = BOUNCE_YELLOW
        first_bounce.physicsBody?.contactTestBitMask = (first_bounce.physicsBody?.collisionBitMask)!
        first_bounce.physicsBody?.dynamic = false
        first_bounce.physicsBody?.restitution = 2
        first_bounce.position = CGPointMake(width/2, 100)
        world.addChild(first_bounce)
        
        win_level.position = CGPointMake(width/2, 510)
        
        if (StartGameMenu.DeviceType.IS_IPHONE_5 || StartGameMenu.DeviceType.IS_IPHONE_4_OR_LESS) {
            win_level.position.y = 460
        }
        world.addChild(win_level)
    }
    
    func createLevel5(world: SKNode, width: CGFloat) {
        let first_bounce = SKShapeNode(circleOfRadius: 30)
        first_bounce.zPosition = 1
        first_bounce.fillColor = SKColor.yellowColor()
        first_bounce.strokeColor = SKColor.clearColor()
        first_bounce.physicsBody = SKPhysicsBody.init(circleOfRadius: 30)
        first_bounce.physicsBody?.collisionBitMask = BOUNCE_YELLOW
        first_bounce.physicsBody?.contactTestBitMask = (first_bounce.physicsBody?.collisionBitMask)!
        first_bounce.physicsBody?.dynamic = false
        first_bounce.physicsBody?.restitution = 2
        first_bounce.position = CGPointMake(120, 100)
        first_bounce.runAction(SKAction.repeatActionForever(SKAction.sequence([SKAction.moveTo(CGPointMake(250, 100), duration: 1), SKAction.moveTo(CGPointMake(120, 100), duration: 1)])))
        world.addChild(first_bounce)
        
        let red_enemy_upper = SKShapeNode(rectOfSize: CGSize(width: 60, height: 60))
        red_enemy_upper.fillColor = SKColor.redColor()
        red_enemy_upper.strokeColor = SKColor.clearColor()
        red_enemy_upper.physicsBody = SKPhysicsBody.init(rectangleOfSize: red_enemy_upper.frame.size)
        red_enemy_upper.physicsBody?.collisionBitMask = REDENEMY_BITMASK
        red_enemy_upper.physicsBody?.contactTestBitMask = (red_enemy_upper.physicsBody?.collisionBitMask)!
        red_enemy_upper.physicsBody?.dynamic = false
        red_enemy_upper.position = CGPointMake(50, 550)
        red_enemy_upper.runAction(SKAction.repeatActionForever(SKAction.sequence([SKAction.moveTo(CGPointMake(50, 550), duration: 1), SKAction.moveTo(CGPointMake(width-50, 550), duration: 1)])))
        red_enemy_upper.runAction(SKAction.repeatActionForever(SKAction.rotateByAngle(2, duration: 0.3)))
        world.addChild(red_enemy_upper)
        
        let red_enemy_lower = SKShapeNode(rectOfSize: CGSize(width: 60, height: 60))
        red_enemy_lower.fillColor = SKColor.redColor()
        red_enemy_lower.strokeColor = SKColor.clearColor()
        red_enemy_lower.physicsBody = SKPhysicsBody.init(rectangleOfSize: red_enemy_lower.frame.size)
        red_enemy_lower.physicsBody?.collisionBitMask = REDENEMY_BITMASK
        red_enemy_lower.physicsBody?.contactTestBitMask = (red_enemy_lower.physicsBody?.collisionBitMask)!
        red_enemy_lower.physicsBody?.dynamic = false
        red_enemy_lower.position = CGPointMake(330, 450)
        red_enemy_lower.runAction(SKAction.repeatActionForever(SKAction.sequence([SKAction.moveTo(CGPointMake(width-50, 450), duration: 1), SKAction.moveTo(CGPointMake(50, 450), duration: 1)])))
        red_enemy_lower.runAction(SKAction.repeatActionForever(SKAction.rotateByAngle(-2, duration: 0.3)))
        world.addChild(red_enemy_lower)
        
        win_level.position = CGPointMake(width/2, 500)
        
        if (StartGameMenu.DeviceType.IS_IPHONE_5 || StartGameMenu.DeviceType.IS_IPHONE_4_OR_LESS) {
            win_level.position.y = 460
            red_enemy_lower.position.y =  420
            red_enemy_lower.runAction(SKAction.repeatActionForever(SKAction.sequence([SKAction.moveTo(CGPointMake(width-50, 420), duration: 1), SKAction.moveTo(CGPointMake(50, 420), duration: 1)])))
            
            red_enemy_upper.position.y = 500
            red_enemy_upper.runAction(SKAction.repeatActionForever(SKAction.sequence([SKAction.moveTo(CGPointMake(50, 500), duration: 1), SKAction.moveTo(CGPointMake(width-50, 500), duration: 1)])))
            
            first_bounce.runAction(SKAction.repeatActionForever(SKAction.sequence([SKAction.moveTo(CGPointMake(230, 100), duration: 1), SKAction.moveTo(CGPointMake(120, 100), duration: 1)])))
        }
        
        world.addChild(win_level)
    }
    
    func createLevel6(world: SKNode, width: CGFloat) {
        
        let outer_rectangle = SKShapeNode(rectOfSize: CGSize(width: 40, height: 30))
        outer_rectangle.fillColor = SKColor.grayColor()
        outer_rectangle.strokeColor = SKColor.grayColor()
        outer_rectangle.lineWidth = 3
        outer_rectangle.name = "moving_elevator"
        outer_rectangle.physicsBody = SKPhysicsBody.init(rectangleOfSize: outer_rectangle.frame.size)
        outer_rectangle.physicsBody?.dynamic = false
        outer_rectangle.physicsBody?.restitution = 0
        outer_rectangle.position = CGPointMake(width-30, 190)
        outer_rectangle.runAction(SKAction.repeatActionForever(SKAction.sequence([SKAction.moveTo(CGPointMake(width-30, 400), duration: 1), SKAction.moveTo(CGPointMake(width-30, 190), duration: 1)])))
        world.addChild(outer_rectangle)
        
        /*let left_rectangle = outer_rectangle.copy() as! SKShapeNode
        left_rectangle.position = CGPointMake(30, 190)
        left_rectangle.fillColor = SKColor.grayColor()
        left_rectangle.strokeColor = SKColor.redColor()
        left_rectangle.physicsBody?.collisionBitMask = REDENEMY_BITMASK
        left_rectangle.physicsBody?.contactTestBitMask = (left_rectangle.physicsBody?.collisionBitMask)!
        left_rectangle.runAction(SKAction.repeatActionForever(SKAction.sequence([SKAction.moveTo(CGPointMake(30, 400), duration: 1), SKAction.moveTo(CGPointMake(30, 190), duration: 1)])))
        world.addChild(left_rectangle)
        */
        win_level.position = CGPointMake(width/2, 552)
        world.addChild(win_level)
        
        var circle_around = SKShapeNode(circleOfRadius: 120)
        circle_around.position = CGPointMake(width/2, 400)
        circle_around.physicsBody = SKPhysicsBody(circleOfRadius: 120)
        if (StartGameMenu.DeviceType.IS_IPHONE_5 || StartGameMenu.DeviceType.IS_IPHONE_4_OR_LESS) {
            win_level.position.y = 460
            circle_around = SKShapeNode(circleOfRadius: 80)
            circle_around.physicsBody = SKPhysicsBody(circleOfRadius: 80)
            circle_around.position = CGPointMake(width/2, 348)
        }
        circle_around.fillColor = SKColor.grayColor()
        circle_around.strokeColor = SKColor.redColor()
        circle_around.lineWidth = 5
        circle_around.runAction(SKAction.repeatActionForever(SKAction.rotateByAngle(2, duration: 1)))
        circle_around.physicsBody?.collisionBitMask = REDENEMY_BITMASK
        circle_around.physicsBody?.contactTestBitMask = (circle_around.physicsBody?.collisionBitMask)!
        circle_around.physicsBody?.dynamic = false
        world.addChild(circle_around)
        
    }
    
    func createLevel7(world: SKNode, width: CGFloat) {
        world.runAction(SKAction.repeatActionForever(make_rain(world, width: UInt32(width))), withKey: "Make Rain")
        
        
        win_level.position = CGPointMake(width-40, 130)
        world.addChild(win_level)
    }
    
    func createLevel8(world: SKNode, width: CGFloat) {
        let first_bounce = SKShapeNode(circleOfRadius: 30)
        first_bounce.zPosition = 1
        first_bounce.fillColor = SKColor.yellowColor()
        first_bounce.strokeColor = SKColor.clearColor()
        first_bounce.physicsBody = SKPhysicsBody.init(circleOfRadius: 30)
        first_bounce.physicsBody?.collisionBitMask = BOUNCE_YELLOW
        first_bounce.physicsBody?.contactTestBitMask = (first_bounce.physicsBody?.collisionBitMask)!
        first_bounce.physicsBody?.dynamic = false
        first_bounce.physicsBody?.restitution = 2
        first_bounce.position = CGPointMake(width-40, 100)
        world.addChild(first_bounce)
        
        let red_circle = SKShapeNode(circleOfRadius: 20)
        red_circle.fillColor = SKColor.redColor()
        red_circle.strokeColor = SKColor.clearColor()
        red_circle.physicsBody = SKPhysicsBody.init(circleOfRadius: 20)
        red_circle.physicsBody?.collisionBitMask = REDENEMY_BITMASK
        red_circle.physicsBody?.contactTestBitMask = (red_circle.physicsBody?.collisionBitMask)!
        red_circle.physicsBody?.dynamic = false
        red_circle.position = CGPointMake(100, 140)
        red_circle.runAction(SKAction.repeatActionForever(SKAction.sequence([SKAction.moveTo(CGPointMake(width-100, 140), duration: 1), SKAction.moveTo(CGPointMake(100, 140), duration: 1)])))
        world.addChild(red_circle)
        
        let door_platform = SKShapeNode(rectOfSize: CGSize(width: 60, height: 10))
        door_platform.fillColor = SKColor.grayColor()
        door_platform.strokeColor = SKColor.clearColor()
        door_platform.name = "door_platform2"
        door_platform.physicsBody = SKPhysicsBody.init(rectangleOfSize: door_platform.frame.size)
        door_platform.physicsBody?.dynamic = false
        door_platform.physicsBody?.restitution = 0
        door_platform.position = CGPointMake(25, 330)
        world.addChild(door_platform)
        
        let upper_foe = SKShapeNode(rectOfSize: CGSize(width: 50, height: 50))
        upper_foe.fillColor = SKColor.redColor()
        upper_foe.strokeColor = SKColor.clearColor()
        upper_foe.physicsBody = SKPhysicsBody.init(rectangleOfSize: upper_foe.frame.size)
        upper_foe.physicsBody?.collisionBitMask = REDENEMY_BITMASK
        upper_foe.physicsBody?.contactTestBitMask = (red_circle.physicsBody?.collisionBitMask)!
        upper_foe.physicsBody?.dynamic = false
        upper_foe.position = CGPointMake(width-20, 650)
        world.addChild(upper_foe)
        
        win_level.position = CGPointMake(25, 365)
        world.addChild(win_level)
        
        var moving_square = SKShapeNode(rectOfSize: CGSize(width: 200, height: 200))
        moving_square.position = CGPointMake(width/2, 400)
        if (StartGameMenu.DeviceType.IS_IPHONE_5 || StartGameMenu.DeviceType.IS_IPHONE_4_OR_LESS) {
            moving_square = SKShapeNode(rectOfSize: CGSize(width: 150, height: 150))
            moving_square.position = CGPointMake(width/2, 350)
            upper_foe.position = CGPointMake(width-20, 550)
        }
        moving_square.fillColor = SKColor.clearColor()
        moving_square.strokeColor = SKColor.grayColor()
        moving_square.lineWidth = 10
        moving_square.physicsBody = SKPhysicsBody.init(rectangleOfSize: moving_square.frame.size)
        moving_square.physicsBody?.dynamic = false
        moving_square.physicsBody?.restitution = 0
        moving_square.runAction(SKAction.repeatActionForever(SKAction.rotateByAngle(1, duration: 0.6)))
        world.addChild(moving_square)
        
    }
    
    func createLevel9(world: SKNode, width: CGFloat) {
        let lonely_word = SKLabelNode(text: "lonely")
        lonely_word.fontName = "AmericanTypeWriter-Bold"
        lonely_word.fontColor = SKColor.redColor()
        lonely_word.physicsBody = SKPhysicsBody.init(rectangleOfSize: lonely_word.frame.size)
        lonely_word.physicsBody?.collisionBitMask = REDENEMY_BITMASK
        lonely_word.physicsBody?.contactTestBitMask = (lonely_word.physicsBody?.collisionBitMask)!
        lonely_word.physicsBody?.dynamic = false
        lonely_word.position = CGPointMake(width-80, 120)
        lonely_word.runAction(SKAction.repeatActionForever(SKAction.sequence([SKAction.moveTo(CGPointMake(150, 120), duration: 1), SKAction.moveTo(CGPointMake(width-80, 120), duration: 1)])))
        world.addChild(lonely_word)
        
        let homesick_word = SKLabelNode(fontNamed: "AmericanTypeWriter-Bold")
        homesick_word.fontColor = SKColor.grayColor()
        homesick_word.text = "homesick"
        homesick_word.physicsBody = SKPhysicsBody.init(rectangleOfSize: CGSize(width: homesick_word.frame.size.width, height: homesick_word.frame.size.height+10))
        homesick_word.physicsBody?.dynamic = false
        homesick_word.physicsBody?.restitution = 0
        homesick_word.position = CGPointMake(width-100, 190)
        homesick_word.runAction(SKAction.repeatActionForever(SKAction.sequence([SKAction.moveTo(CGPointMake(width-100, 290), duration: 1), SKAction.moveTo(CGPointMake(width-100, 190), duration: 1)])))
        world.addChild(homesick_word)
        
        let miss_you_word = SKLabelNode(text: "miss you")
        miss_you_word.fontColor = SKColor.yellowColor()
        miss_you_word.physicsBody = SKPhysicsBody.init(rectangleOfSize: miss_you_word.frame.size)
        miss_you_word.physicsBody?.collisionBitMask = BOUNCE_YELLOW
        miss_you_word.physicsBody?.contactTestBitMask = (miss_you_word.physicsBody?.collisionBitMask)!
        miss_you_word.fontName = "AmericanTypeWriter-Light"
        miss_you_word.position = CGPointMake(80, 415)
        miss_you_word.physicsBody?.dynamic = false
        miss_you_word.physicsBody?.restitution = 2
        world.addChild(miss_you_word)
        
        win_level.position = CGPointMake(50, 600)
        world.addChild(win_level)

        if (StartGameMenu.DeviceType.IS_IPHONE_5) {
            win_level.position = CGPointMake(50, 500)
            miss_you_word.position = CGPointMake(80, 340)
        } else if (StartGameMenu.DeviceType.IS_IPHONE_4_OR_LESS) {
            win_level.position = CGPointMake(50, 440)
            miss_you_word.position = CGPointMake(80, 330)
        }
    }
    
    func createLevel10(world: SKNode, width: CGFloat) {
        
        world.runAction(SKAction.repeatActionForever(make_rain(world, width: UInt32(width))), withKey: "Make Rain")
        
        let platform_left_bottom = SKShapeNode(rectOfSize: CGSize(width: 70, height: 10))
        platform_left_bottom.fillColor = SKColor.grayColor()
        platform_left_bottom.position = CGPointMake(100, 330)
        platform_left_bottom.strokeColor = SKColor.clearColor()
        platform_left_bottom.name = "door_platform2"
        platform_left_bottom.physicsBody = SKPhysicsBody.init(rectangleOfSize: platform_left_bottom.frame.size)
        platform_left_bottom.physicsBody?.dynamic = false
        platform_left_bottom.physicsBody?.restitution = 0
        world.addChild(platform_left_bottom)
        
        let platform_right_bottom = SKShapeNode(rectOfSize: CGSize(width: 70, height: 10))
        platform_right_bottom.fillColor = SKColor.grayColor()
        platform_right_bottom.position = CGPointMake(320, 200)
        platform_right_bottom.strokeColor = SKColor.clearColor()
        platform_right_bottom.name = "door_platform2"
        platform_right_bottom.physicsBody = SKPhysicsBody.init(rectangleOfSize: platform_right_bottom.frame.size)
        platform_right_bottom.physicsBody?.dynamic = false
        platform_right_bottom.physicsBody?.restitution = 0
        world.addChild(platform_right_bottom)
        
        let platform_right_top = SKShapeNode(rectOfSize: CGSize(width: 70, height: 10))
        platform_right_top.fillColor = SKColor.grayColor()
        platform_right_top.position = CGPointMake(300, 470)
        platform_right_top.strokeColor = SKColor.clearColor()
        platform_right_top.name = "door_platform2"
        platform_right_top.physicsBody = SKPhysicsBody.init(rectangleOfSize: platform_right_top.frame.size)
        platform_right_top.physicsBody?.dynamic = false
        platform_right_top.physicsBody?.restitution = 0
        world.addChild(platform_right_top)
        
        let platform_door = SKShapeNode(rectOfSize: CGSize(width: 70, height: 10))
        platform_door.fillColor = SKColor.grayColor()
        platform_door.position = CGPointMake(width/2, 590)
        platform_door.strokeColor = SKColor.clearColor()
        platform_door.name = "door_platform2"
        platform_door.physicsBody = SKPhysicsBody.init(rectangleOfSize: platform_door.frame.size)
        platform_door.physicsBody?.dynamic = false
        platform_door.physicsBody?.restitution = 0
        world.addChild(platform_door)
        
        win_level.position = CGPointMake(width/2, 626)
        world.addChild(win_level)
        
        if (StartGameMenu.DeviceType.IS_IPHONE_5) {
            win_level.position = CGPointMake(width/2, 500)
            platform_door.position = CGPointMake(width/2, 464)
            platform_left_bottom.position = CGPointMake(30, 330)
            platform_right_top.position = CGPointMake(230, 390)
            platform_right_bottom.position = CGPointMake(250, 200)
        } else if (StartGameMenu.DeviceType.IS_IPHONE_4_OR_LESS) {
            win_level.position = CGPointMake(width/2, 420)
            platform_door.position = CGPointMake(width/2, 384)
            platform_left_bottom.position = CGPointMake(50, 280)
            platform_right_top.removeFromParent()
            platform_right_bottom.position = CGPointMake(250, 200)
        }
    }
    
    func createLevel11(world: SKNode, width: CGFloat) {
        let first_bounce = SKShapeNode(circleOfRadius: 40)
        first_bounce.zPosition = 1
        first_bounce.fillColor = SKColor.yellowColor()
        first_bounce.strokeColor = SKColor.clearColor()
        first_bounce.physicsBody = SKPhysicsBody.init(circleOfRadius: 40)
        first_bounce.physicsBody?.collisionBitMask = BOUNCE_YELLOW
        first_bounce.physicsBody?.contactTestBitMask = (first_bounce.physicsBody?.collisionBitMask)!
        first_bounce.physicsBody?.dynamic = false
        first_bounce.physicsBody?.restitution = 2
        first_bounce.position = CGPointMake(width-70, 100)
        world.addChild(first_bounce)
        
        let red_bottom = SKShapeNode(rectOfSize: CGSize(width: width-200, height: 5))
        red_bottom.fillColor = SKColor.redColor()
        red_bottom.strokeColor = SKColor.clearColor()
        red_bottom.physicsBody = SKPhysicsBody.init(rectangleOfSize: red_bottom.frame.size)
        red_bottom.physicsBody?.collisionBitMask = REDENEMY_BITMASK
        red_bottom.physicsBody?.contactTestBitMask = (red_bottom.physicsBody?.collisionBitMask)!
        red_bottom.physicsBody?.dynamic = false
        red_bottom.position = CGPointMake((width/2)-25, 100)
        world.addChild(red_bottom)
        
        let door_platform = SKShapeNode(rectOfSize: CGSize(width: 60, height: 10))
        door_platform.fillColor = SKColor.grayColor()
        door_platform.strokeColor = SKColor.clearColor()
        door_platform.name = "door_platform2"
        door_platform.physicsBody = SKPhysicsBody.init(rectangleOfSize: door_platform.frame.size)
        door_platform.physicsBody?.dynamic = false
        door_platform.physicsBody?.restitution = 0
        door_platform.position = CGPointMake(25, 330)
        world.addChild(door_platform)
        
        let final_platform = SKShapeNode(rectOfSize: CGSize(width: 60, height: 10))
        final_platform.fillColor = SKColor.grayColor()
        final_platform.strokeColor = SKColor.clearColor()
        final_platform.name = "door_platform2"
        final_platform.physicsBody = SKPhysicsBody.init(rectangleOfSize: door_platform.frame.size)
        final_platform.physicsBody?.dynamic = false
        final_platform.physicsBody?.restitution = 0
        final_platform.position = CGPointMake(125, 500)
        world.addChild(final_platform)
        
        win_level.position = CGPointMake(25, 365)
        world.addChild(win_level)
        
        var moving_square = SKShapeNode(rectOfSize: CGSize(width: 150, height: 150))
        moving_square.position = CGPointMake(width/2, 400)
        if (StartGameMenu.DeviceType.IS_IPHONE_4_OR_LESS) {
            moving_square = SKShapeNode(rectOfSize: CGSize(width: 75, height: 75))
            moving_square.position = CGPointMake(width/2, 345)
            win_level.position = CGPointMake(240, 365)
            door_platform.position = CGPointMake(240, 330)
        }
        moving_square.fillColor = SKColor.grayColor()
        moving_square.strokeColor = SKColor.redColor()
        moving_square.lineWidth = 5
        moving_square.physicsBody = SKPhysicsBody.init(rectangleOfSize: moving_square.frame.size)
        moving_square.physicsBody?.dynamic = false
        moving_square.physicsBody?.restitution = 0
        moving_square.physicsBody?.collisionBitMask = REDENEMY_BITMASK
        moving_square.physicsBody?.contactTestBitMask = (moving_square.physicsBody?.collisionBitMask)!
        moving_square.runAction(SKAction.repeatActionForever(SKAction.rotateByAngle(1, duration: 0.6)))
        world.addChild(moving_square)
        
    }
    
    func createLevel12(world: SKNode, width: CGFloat) {
        let bounce_bottom = SKShapeNode(rectOfSize: CGSize(width: width-50, height: 30))
        bounce_bottom.zPosition = 1
        bounce_bottom.fillColor = SKColor.yellowColor()
        bounce_bottom.strokeColor = SKColor.clearColor()
        bounce_bottom.physicsBody = SKPhysicsBody.init(rectangleOfSize: bounce_bottom.frame.size)
        bounce_bottom.physicsBody?.collisionBitMask = BOUNCE_YELLOW
        bounce_bottom.physicsBody?.contactTestBitMask = (bounce_bottom.physicsBody?.collisionBitMask)!
        bounce_bottom.physicsBody?.dynamic = false
        bounce_bottom.physicsBody?.restitution = 1.1
        bounce_bottom.position = CGPointMake((width/2+50), 115)
        world.addChild(bounce_bottom)
        
        let bounce_top_right = SKShapeNode(rectOfSize: CGSize(width: 30, height: 600))
        bounce_top_right.zPosition = 1
        bounce_top_right.fillColor = SKColor.yellowColor()
        bounce_top_right.strokeColor = SKColor.clearColor()
        bounce_top_right.physicsBody = SKPhysicsBody.init(rectangleOfSize: bounce_top_right.frame.size)
        bounce_top_right.physicsBody?.collisionBitMask = BOUNCE_YELLOW
        bounce_top_right.physicsBody?.contactTestBitMask = (bounce_top_right.physicsBody?.collisionBitMask)!
        bounce_top_right.physicsBody?.dynamic = false
        bounce_top_right.physicsBody?.restitution = 1
        bounce_top_right.position = CGPointMake((width-15), 350)
        world.addChild(bounce_top_right)
        
        let bounce_middle = SKShapeNode(rectOfSize: CGSize(width: width-100, height: 30))
        bounce_middle.zPosition = 1
        bounce_middle.fillColor = SKColor.yellowColor()
        bounce_middle.strokeColor = SKColor.clearColor()
        bounce_middle.physicsBody = SKPhysicsBody.init(rectangleOfSize: bounce_middle.frame.size)
        bounce_middle.physicsBody?.collisionBitMask = BOUNCE_YELLOW
        bounce_middle.physicsBody?.contactTestBitMask = (bounce_middle.physicsBody?.collisionBitMask)!
        bounce_middle.physicsBody?.dynamic = false
        bounce_middle.physicsBody?.restitution = 1
        bounce_middle.position = CGPointMake((width/2)-100, 350)
        world.addChild(bounce_middle)
        
        let bounce_top = SKShapeNode(rectOfSize: CGSize(width: width, height: 30))
        bounce_top.zPosition = 1
        bounce_top.fillColor = SKColor.yellowColor()
        bounce_top.strokeColor = SKColor.clearColor()
        bounce_top.physicsBody = SKPhysicsBody.init(rectangleOfSize: bounce_middle.frame.size)
        bounce_top.physicsBody?.collisionBitMask = BOUNCE_YELLOW
        bounce_top.physicsBody?.contactTestBitMask = (bounce_top.physicsBody?.collisionBitMask)!
        bounce_top.physicsBody?.dynamic = false
        bounce_top.physicsBody?.restitution = 1
        bounce_top.position = CGPointMake((width/2), 650)
        world.addChild(bounce_top)
        
        let bottom_red_circle_left = SKShapeNode(circleOfRadius: 20)
        bottom_red_circle_left.fillColor = SKColor.redColor()
        bottom_red_circle_left.strokeColor = SKColor.clearColor()
        bottom_red_circle_left.physicsBody = SKPhysicsBody.init(circleOfRadius: 20)
        bottom_red_circle_left.physicsBody?.collisionBitMask = REDENEMY_BITMASK
        bottom_red_circle_left.physicsBody?.contactTestBitMask = (bottom_red_circle_left.physicsBody?.collisionBitMask)!
        bottom_red_circle_left.physicsBody?.dynamic = false
        bottom_red_circle_left.position = CGPointMake(100, 180)
        bottom_red_circle_left.runAction(SKAction.repeatActionForever(SKAction.sequence([SKAction.moveTo(CGPointMake(100, 300), duration: 1), SKAction.moveTo(CGPointMake(100, 180), duration: 1)])))
        world.addChild(bottom_red_circle_left)
        
        let bottom_red_circle_right = bottom_red_circle_left.copy() as! SKShapeNode
        bottom_red_circle_right.position = CGPointMake(300, 180)
        bottom_red_circle_right.runAction(SKAction.repeatActionForever(SKAction.sequence([SKAction.moveTo(CGPointMake(300, 300), duration: 1), SKAction.moveTo(CGPointMake(300, 180), duration: 1)])))
        world.addChild(bottom_red_circle_right)
        
        let red_circle_top = bottom_red_circle_left.copy() as! SKShapeNode
        red_circle_top.position = CGPointMake(width/2, 400)
        red_circle_top.runAction(SKAction.repeatActionForever(SKAction.sequence([SKAction.moveTo(CGPointMake(width/2, 600), duration: 1), SKAction.moveTo(CGPointMake(width/2, 400), duration: 1)])))
        world.addChild(red_circle_top)
        
        win_level.position = CGPointMake(25, 420)
        world.addChild(win_level)
        
        if (StartGameMenu.DeviceType.IS_IPHONE_5) {
            bottom_red_circle_right.position = CGPointMake(240, 180)
            bottom_red_circle_right.runAction(SKAction.repeatActionForever(SKAction.sequence([SKAction.moveTo(CGPointMake(240, 300), duration: 1), SKAction.moveTo(CGPointMake(240, 180), duration: 1)])))
            bounce_top.position = CGPointMake((width/2), 555)
            red_circle_top.position = CGPointMake((width/2)+100, 400)
            red_circle_top.runAction(SKAction.repeatActionForever(SKAction.sequence([SKAction.moveTo(CGPointMake((width/2)+100, 500), duration: 1), SKAction.moveTo(CGPointMake((width/2)+100, 400), duration: 1)])))
        } else if (StartGameMenu.DeviceType.IS_IPHONE_4_OR_LESS) {
            bottom_red_circle_right.position = CGPointMake(260, 180)
            bottom_red_circle_right.runAction(SKAction.repeatActionForever(SKAction.sequence([SKAction.moveTo(CGPointMake(260, 300), duration: 1), SKAction.moveTo(CGPointMake(260, 180), duration: 1)])))
            bounce_top.position = CGPointMake((width/2), 480)
            red_circle_top.position = CGPointMake((width/2)+100, 350)
            red_circle_top.runAction(SKAction.repeatActionForever(SKAction.sequence([SKAction.moveTo(CGPointMake((width/2)+100, 430), duration: 1), SKAction.moveTo(CGPointMake((width/2)+100, 350), duration: 1)])))
        } else if (StartGameMenu.DeviceType.IS_IPHONE_6P) {
            bottom_red_circle_right.position = CGPointMake(350, 180)
            bottom_red_circle_right.runAction(SKAction.repeatActionForever(SKAction.sequence([SKAction.moveTo(CGPointMake(350, 300), duration: 1), SKAction.moveTo(CGPointMake(350, 180), duration: 1)])))
        }
    }
    
    func createLevel13(world: SKNode, width: CGFloat) {
        
    }
    
    func make_rain(world: SKNode, width: UInt32) -> SKAction {
        let makeRain = SKAction.sequence([SKAction.runBlock({
            let random_position = CGFloat(arc4random_uniform(width))
            let falling_rain = SKShapeNode(rectOfSize: CGSize(width: 30, height: 2))
            falling_rain.fillColor = SKColor.redColor()
            falling_rain.strokeColor = SKColor.clearColor()
            falling_rain.physicsBody = SKPhysicsBody.init(rectangleOfSize: falling_rain.frame.size)
            falling_rain.physicsBody?.dynamic = false
            falling_rain.physicsBody?.restitution = 0
            falling_rain.physicsBody?.collisionBitMask = self.REDENEMY_BITMASK
            falling_rain.physicsBody?.contactTestBitMask = (falling_rain.physicsBody?.collisionBitMask)!
            falling_rain.position = CGPointMake(random_position, 800)
            world.addChild(falling_rain)
            falling_rain.runAction(SKAction.moveTo(CGPointMake(random_position, 0), duration: 4)) {
                falling_rain.removeFromParent()
            }
            falling_rain.runAction(SKAction.repeatActionForever(SKAction.rotateByAngle(2, duration: 0.1)))
            
        }), SKAction.waitForDuration(0.5)])
        
        return makeRain
    }
}
