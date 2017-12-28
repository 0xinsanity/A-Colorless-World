//
//  PlayGameScreen.swift
//  An Endless Run
//
//  Created by Noah Hanover on 4/4/16.
//  Copyright © 2016 Noah Hanover. All rights reserved.
//

import SpriteKit
import AVFoundation

class PlayGameScene: SKScene, SKPhysicsContactDelegate {
    var background_node: SKSpriteNode!
    var main_player: SKShapeNode!
    var node_world: SKNode!
    var level_number: Int!
    var colorless_ground: SKShapeNode!
    var level_indicator: SKLabelNode!
    var level_shower: SKLabelNode!
    var level_quote: SKLabelNode!
    var curtain_cover: SKShapeNode!
    var pause_button: PausedButton!
    var sounds_player: AVAudioPlayer!
    
    init(level: Int, size: CGSize) {
        if (level == 0) {
            if (NSUserDefaults.standardUserDefaults().valueForKey("Level") == nil) {
                level_number = 1
            } else {
                level_number = NSUserDefaults.standardUserDefaults().valueForKey("Level") as! Int
            }
        } else {
            level_number = level
        }
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
        
        let music_loop_url = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("ingame_extended", ofType: "wav")!)
        if (AudioPlayerSingleton.sharedInstance.url != music_loop_url) {
            AudioPlayerSingleton.sharedInstance.stop()
            do {
                AudioPlayerSingleton.sharedInstance = try AudioPlayerSingleton(contentsOfURL: music_loop_url)
            } catch {
                print("Cant play")
            }
            AudioPlayerSingleton.sharedInstance.numberOfLoops = -1
            AudioPlayerSingleton.sharedInstance.prepareToPlay()
            AudioPlayerSingleton.sharedInstance.play()
            
            if (NSUserDefaults.standardUserDefaults().valueForKey("Music") != nil && NSUserDefaults.standardUserDefaults().valueForKey("Music") as! Bool == false) {
                AudioPlayerSingleton.sharedInstance.volume = 0
            }

        }
        
        self.backgroundColor = SKColor.lightGrayColor()
        background_node = SKSpriteNode()
        background_node.size = (self.view?.frame.size)!
        background_node.zPosition = -1
        background_node.position = CGPointMake((self.view?.frame.size.width)!/2, (self.view?.frame.size.height)!/2)
        
        node_world = SKNode()
        physicsWorld.gravity = CGVectorMake(0, -3)
        physicsWorld.contactDelegate = self
        self.addChild(node_world)
        node_world.addChild(background_node)
        
        let borderBody = SKPhysicsBody(edgeLoopFromRect: self.view!.frame)
        node_world.physicsBody = borderBody
        borderBody.friction = 0
        borderBody.restitution = 0
        
        main_player = SKShapeNode(rectOfSize: CGSize(width: 30, height: 30))
        main_player.fillColor = SKColor.greenColor()
        main_player.strokeColor = SKColor.blackColor()
        main_player.name = "main_move"
        main_player.physicsBody = SKPhysicsBody.init(rectangleOfSize: main_player.frame.size)
        main_player.position = CGPointMake(30, 150)
        main_player.physicsBody?.dynamic = true
        main_player.physicsBody?.allowsRotation = false
        main_player.physicsBody?.restitution = 0
        main_player.physicsBody?.collisionBitMask = 1
        main_player.zPosition = 2
        node_world.addChild(main_player)
        
        colorless_ground = SKShapeNode(rectOfSize: CGSize(width: (self.view?.frame.width)!+5, height: 200))
        colorless_ground.fillColor = SKColor.grayColor()
        colorless_ground.strokeColor = SKColor.clearColor()
        colorless_ground.physicsBody = SKPhysicsBody.init(rectangleOfSize: colorless_ground.frame.size)
        colorless_ground.position = CGPointMake((self.view?.frame.size.width)!/2, 0)
        colorless_ground.physicsBody?.dynamic = false
        colorless_ground.physicsBody?.restitution = 0
        colorless_ground.zPosition = 2
        node_world.addChild(colorless_ground)
        
        pause_button = PausedButton(scene: self, world: node_world)
        pause_button.position = CGPointMake((self.view?.frame.size.width)!/2, 55)
        pause_button.zPosition = 3.1
        pause_button.name = "pause"
        pause_button.userInteractionEnabled = true
        node_world.addChild(pause_button)
        
        curtain_cover = SKShapeNode(rectOfSize: self.view!.frame.size)
        curtain_cover.fillColor = SKColor.blackColor()
        curtain_cover.strokeColor = SKColor.clearColor()
        curtain_cover.position = CGPointMake(self.view!.frame.size.width/2, self.view!.frame.size.height/2)
        curtain_cover.alpha = 0
        curtain_cover.zPosition = 4
        node_world.addChild(curtain_cover)

        initializeLevelText()
        level_changer(level_number)
        super.didMoveToView(view)
    }
    
    func initializeLevelText() {
        level_shower = SKLabelNode(fontNamed: "AmericanTypeWriter-Bold")
        level_shower.fontColor = SKColor(white: 0.5, alpha: 1)
        level_shower.fontSize = 40
        level_shower.position = CGPointMake((self.view?.frame.size.width)!/2, 550)
        level_shower.text = "LEVEL"
        level_shower.zPosition = 2
        node_world.addChild(level_shower)
        
        level_indicator = SKLabelNode(fontNamed: "AmericanTypeWriter")
        level_indicator.fontColor = SKColor(white: 0.3, alpha: 1)
        level_indicator.fontSize = 80
        level_indicator.position = CGPointMake((self.view?.frame.size.width)!/2, 480)
        level_indicator.zPosition = 2
        node_world.addChild(level_indicator)
        
        level_quote = SKLabelNode(fontNamed: "AmericanTypeWriter")
        level_quote.fontColor = SKColor(white: 0.9, alpha: 1)
        level_quote.fontSize = 30
        level_quote.position = CGPointMake((self.view?.frame.size.width)!/2, 440)
        level_quote.zPosition = 2
        node_world.addChild(level_quote)
        
        if (StartGameMenu.DeviceType.IS_IPHONE_5) {
            level_shower.position = CGPointMake((self.view?.frame.size.width)!/2, 510)
            level_indicator.position = CGPointMake((self.view?.frame.size.width)!/2, 440)
            level_quote.position = CGPointMake((self.view?.frame.size.width)!/2, 400)
            
            level_shower.fontSize = 35
            level_indicator.fontSize = 75
            level_quote.fontSize = 25
        } else if (StartGameMenu.DeviceType.IS_IPHONE_4_OR_LESS) {
            level_shower.position = CGPointMake((self.view?.frame.size.width)!/2, 410)
            level_indicator.position = CGPointMake((self.view?.frame.size.width)!/2, 340)
            level_quote.position = CGPointMake((self.view?.frame.size.width)!/2, 300)
            
            level_shower.fontSize = 30
            level_indicator.fontSize = 70
            level_quote.fontSize = 24
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let sound_url = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("jumpA", ofType: "wav")!)
        do {
            sounds_player = try AVAudioPlayer(contentsOfURL: sound_url)
        } catch {
            print("Cant play")
        }
        sounds_player.numberOfLoops = 0
        if (main_player.physicsBody?.velocity.dy == 0) {
            if (touches.first?.locationInView(self.view).x <= (self.view?.frame.size.width)!/2) {
                main_player.physicsBody?.velocity = CGVectorMake(-150, 400)
            } else {
                main_player.physicsBody?.velocity = CGVectorMake(150, 400)
            }
            
            sounds_player.prepareToPlay()
            sounds_player.play()
        } else {
            if (touches.first?.locationInView(self.view).x <= (self.view?.frame.size.width)!/2) {
                main_player.physicsBody?.velocity = CGVectorMake(-150, (main_player.physicsBody?.velocity.dy)!)
            } else {
                main_player.physicsBody?.velocity = CGVectorMake(150, (main_player.physicsBody?.velocity.dy)!)
            }
        }
        super.touchesBegan(touches, withEvent: event)
    }
    
    func level_changer(level: Int) {
        level_indicator.text = "\(level)"
        let create_level =  LevelCreator()
        create_level.initialize_door()
        if (level == 1) {
            level_quote.text = "\"Go To The Black Door\""
            create_level.createLevel1(node_world, width: (self.view?.frame.size.width)!)
        } else if (level == 2) {
            level_quote.text = "\"The Evil Red Appears\""
            create_level.createLevel2(node_world)
            
        } else if (level == 3) {
            level_quote.text = "\"Not A Friend\""
            create_level.createLevel3(node_world, width: (self.view?.frame.size.width)!)
            
        } else if (level == 4) {
            if (NSUserDefaults.standardUserDefaults().valueForKey("Level 4") == nil) {
                AudioPlayerSingleton.sharedInstance.stop()
                self.view?.presentScene(StoryAnimation(size: (self.view?.frame.size)!, level: 4), transition: SKTransition.fadeWithDuration(3))
                self.removeFromParent()
                return
            }
            level_quote.text = "\"Is That You Yellow?\""
            create_level.createLevel4(node_world, width: (self.view?.frame.size.width)!)
            
        } else if (level == 5) {
            level_quote.text = "\"Red vs Yellow & Green\""
            create_level.createLevel5(node_world, width: (self.view?.frame.size.width)!)
            
        } else if (level == 6) {
            level_quote.text = "\"Do Not Be Fooled!\""
            create_level.createLevel6(node_world, width: (self.view?.frame.size.width)!)
        } else if (level == 7) {
            level_quote.text = "\"What Foe Is This!?\""
            create_level.createLevel7(node_world, width: (self.view?.frame.size.width)!)
        } else if (level == 8) {
            if (NSUserDefaults.standardUserDefaults().valueForKey("Level 8") == nil) {
                AudioPlayerSingleton.sharedInstance.stop()
                self.view?.presentScene(StoryAnimation(size: (self.view?.frame.size)!, level: 8), transition: SKTransition.fadeWithDuration(3))
                self.removeFromParent()
                return
            }
            
            level_quote.text = "\"A Lifeless Brother\""
            create_level.createLevel8(node_world, width: (self.view?.frame.size.width)!)
        } else if (level == 9) {
            level_quote.text = "\"Words Can Help Or Hurt\""
            create_level.createLevel9(node_world, width: (self.view?.frame.size.width)!)
            
        } else if (level == 10) {
            level_quote.text = "\"A Never Ending Journey\""
            create_level.createLevel10(node_world, width: (self.view?.frame.size.width)!)
        } else if (level == 11) {
            level_quote.text = "\"An Unloyal Brother\""
            create_level.createLevel11(node_world, width: (self.view?.frame.size.width)!)
        } else if (level == 12) {
            if (NSUserDefaults.standardUserDefaults().valueForKey("Level 12") == nil) {
                AudioPlayerSingleton.sharedInstance.stop()
                self.view?.presentScene(StoryAnimation(size: (self.view?.frame.size)!, level: 12), transition: SKTransition.fadeWithDuration(3))
                self.removeFromParent()
                return
            }
            level_quote.text = "\"A Bouncy Terror House\""
            create_level.createLevel12(node_world, width: (self.view?.frame.size.width)!)
        } else if (level == 13) {
            if (NSUserDefaults.standardUserDefaults().valueForKey("FINAL") == nil) {
                AudioPlayerSingleton.sharedInstance.stop()
                self.view?.presentScene(StoryAnimation(size: (self.view?.frame.size)!, level: 16), transition: SKTransition.fadeWithDuration(3))
                self.removeFromParent()
                return
            }
            self.view?.presentScene(FinalPage(size: (self.view?.frame.size)!), transition: SKTransition.fadeWithDuration(3))
            
            //level_quote.text = "\"Iconic Level Goes Here\""
            //create_level.createLevel13(node_world, width: (self.view?.frame.size.width)!)
        } else if (level == 14) {
            
        } else if (level == 15) {
            
        } else {
            if (NSUserDefaults.standardUserDefaults().valueForKey("FINAL") == nil) {
                self.view?.presentScene(StoryAnimation(size: (self.view?.frame.size)!, level: 16), transition: SKTransition.fadeWithDuration(3))
                self.removeFromParent()
                return
            }
            self.view?.presentScene(FinalPage(size: (self.view?.frame.size)!), transition: SKTransition.fadeWithDuration(3))
        }
        
        level_quote.runAction(SKAction.sequence([SKAction.fadeInWithDuration(1), SKAction.waitForDuration(1), SKAction.fadeOutWithDuration(1)]))
        level_shower.runAction(SKAction.sequence([SKAction.fadeInWithDuration(1), SKAction.waitForDuration(1), SKAction.fadeOutWithDuration(1)]))
        level_indicator.runAction(SKAction.sequence([SKAction.fadeInWithDuration(1), SKAction.waitForDuration(1), SKAction.fadeOutWithDuration(1)]))
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        if (contact.bodyB.node?.physicsBody?.collisionBitMask == 2 || contact.bodyA.node?.physicsBody?.collisionBitMask == 2) {
            
            let sound_url = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("doorsound", ofType: "wav")!)
            do {
                sounds_player = try AVAudioPlayer(contentsOfURL: sound_url)
            } catch {
                print("Cant play")
            }
            sounds_player.numberOfLoops = 0
            //sounds_player.prepareToPlay()
            sounds_player.play()
            
            if (contact.bodyA.node?.name == "door") {
                main_player.runAction(SKAction.moveTo((contact.bodyA.node?.position)!, duration: 0.3))
            } else {
                main_player.runAction(SKAction.moveTo((contact.bodyB.node?.position)!, duration: 0.3))
            }
            beatLevel()
        } else if (contact.bodyA.node?.physicsBody?.collisionBitMask == 3 || contact.bodyB.node?.physicsBody?.collisionBitMask == 3) {
            
            let sound_url = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("deathsound2", ofType: "wav")!)
            do {
                sounds_player = try AVAudioPlayer(contentsOfURL: sound_url)
            } catch {
                print("Cant play")
            }
            sounds_player.numberOfLoops = 0
            //sounds_player.prepareToPlay()
            sounds_player.play()
            
            var r1: CGFloat = 0.0
            var g1: CGFloat = 0.0
            var b1: CGFloat = 0.0
            var a1: CGFloat = 0.0
            var r2: CGFloat = 0.0
            var g2: CGFloat = 0.0
            var b2: CGFloat = 0.0
            var a2: CGFloat = 0.0
            SKColor.greenColor().getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
            SKColor.darkGrayColor().getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
            
            main_player.runAction(SKAction.customActionWithDuration(0.3, actionBlock: { (node: SKNode, float: CGFloat) in
                let fraction = float / 0.3
                
                let col3 = SKColor(red: self.lerp(r1, b: r2, fraction: fraction), green: self.lerp(g1, b: g2, fraction: fraction), blue: self.lerp(b1, b: b2, fraction: fraction), alpha: self.lerp(a1, b: a2, fraction: fraction))
                
                self.main_player.fillColor = col3
            }))
            // Red Enemy
            restartLevel()
        } else if (contact.bodyA.node?.physicsBody?.collisionBitMask == 4 || contact.bodyB.node?.physicsBody?.collisionBitMask == 4) {
            let sound_url = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("jumpB", ofType: "wav")!)
            do {
                sounds_player = try AVAudioPlayer(contentsOfURL: sound_url)
            } catch {
                print("Cant play")
            }
            sounds_player.numberOfLoops = 0
            sounds_player.prepareToPlay()
            sounds_player.play()
        }
    }
    
    func lerp(a: CGFloat, b: CGFloat, fraction: CGFloat) -> CGFloat {
        return (b - a) * fraction + a
    }
    
    func beatLevel() {
        physicsWorld.speed = 0
        
        let current_level = NSUserDefaults.standardUserDefaults().valueForKey("Level")
        if (current_level != nil && (current_level as! Int) == 13){
            level_number = 13
        } else {
            level_number = level_number+1
        }
        
        NSUserDefaults.standardUserDefaults().setInteger(level_number, forKey: "Level")
        
        curtain_cover.runAction(SKAction.sequence([SKAction.fadeInWithDuration(1.5), SKAction.waitForDuration(0.2)])) {
            self.main_player.physicsBody?.velocity = CGVectorMake(0, 0)
            self.main_player.position = CGPointMake(30, 150)
            self.removeObstacles()
            self.level_changer(self.level_number)
            self.physicsWorld.speed = 1
            self.curtain_cover.runAction(SKAction.fadeOutWithDuration(1.5))
        }
    }
    
    func restartLevel() {
        self.physicsWorld.speed = 0
        
        curtain_cover.runAction(SKAction.sequence([SKAction.fadeInWithDuration(1.5), SKAction.waitForDuration(0.2)])) {
            self.main_player.position = CGPointMake(30, 150)
            self.main_player.physicsBody?.velocity = CGVectorMake(0, 0)
            self.removeObstacles()
            self.level_changer(self.level_number)
            self.physicsWorld.speed = 1
            self.curtain_cover.runAction(SKAction.fadeOutWithDuration(1.5))
            self.main_player.fillColor = SKColor.greenColor()
        }

    }
    
    func removeObstacles() {
        node_world.removeAllChildren()
        if (node_world.actionForKey("Make Rain") != nil) {
            node_world.removeActionForKey("Make Rain")
        }
        node_world.addChild(main_player)
        node_world.addChild(level_quote)
        node_world.addChild(level_shower)
        node_world.addChild(level_indicator)
        node_world.addChild(colorless_ground)
        node_world.addChild(curtain_cover)
        node_world.addChild(background_node)
        node_world.addChild(pause_button)
    }
}