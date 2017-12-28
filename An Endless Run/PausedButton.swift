//
//  PausedButton.swift
//  A Colorless World
//
//  Created by Noah Hanover on 4/24/16.
//  Copyright © 2016 Noah Hanover. All rights reserved.
//

import SpriteKit
import AVFoundation

class PausedButton: SKSpriteNode {
    var main_scene: PlayGameScene!
    var background_screen: SKShapeNode!
    var exit_button: ExitButton!
    var restart_button: RestartButton!
    var node_world: SKNode!
    var button_player: AVAudioPlayer!
    
    init(scene: PlayGameScene, world: SKNode!) {
        super.init(texture: nil, color: UIColor.clearColor(), size: CGSizeMake(32, 32))
        
        let button_url = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("buttonsound_basic", ofType: "wav")!)
        do {
            button_player = try AudioPlayerSingleton(contentsOfURL: button_url)
        } catch {
            print("Cant play")
        }
        button_player.numberOfLoops = 0
        
        node_world = world
        
        let mini_circle = SKShapeNode(circleOfRadius: 10)
        mini_circle.fillColor = SKColor.whiteColor()
        mini_circle.position = CGPointMake(0, 0)
        let outside_circle = SKShapeNode(circleOfRadius: 16)
        outside_circle.position = CGPointMake(0, 0)
        outside_circle.strokeColor = SKColor.whiteColor()
        outside_circle.lineWidth = 2
        self.addChild(mini_circle)
        self.addChild(outside_circle)
        self.main_scene = scene
        
        background_screen = SKShapeNode(rectOfSize:CGSizeMake(main_scene.size.width+5, 200))
        background_screen.fillColor = SKColor.blackColor()
        background_screen.zPosition = 3
        background_screen.lineWidth = 0
        background_screen.position = CGPointMake(scene.view!.frame.size.width/2, 0)
        background_screen.alpha = 0
        
        let label_exit = SKLabelNode(fontNamed: "AmericanTypeWriter")
        label_exit.fontColor = SKColor.whiteColor()
        label_exit.text = "Exit"
        label_exit.fontSize = 17
        label_exit.position = CGPointMake(-125, 14)
        
        let label_pause = label_exit.copy() as! SKLabelNode
        label_pause.text = "Pause"
        label_pause.position.x = 0
        
        let label_restart = label_exit.copy() as! SKLabelNode
        label_restart.text = "Restart"
        label_restart.position.x = 130
        
        if (StartGameMenu.DeviceType.IS_IPHONE_5 || StartGameMenu.DeviceType.IS_IPHONE_4_OR_LESS) {
            label_restart.position.x = 100
            label_exit.position.x = -100
        } else if (StartGameMenu.DeviceType.IS_IPHONE_6P) {
            label_restart.position.x = 145
            label_exit.position.x = -148
        }
        background_screen.addChild(label_restart)
        background_screen.addChild(label_pause)
        background_screen.addChild(label_exit)
        main_scene.addChild(background_screen)
        
        let exit_circle: SKShapeNode = outside_circle.copy() as! SKShapeNode
        let x_img = SKSpriteNode(imageNamed: "exit_button")
        x_img.size = CGSize(width: 24, height: 24)
        exit_button = ExitButton(scene: main_scene)
        exit_button.userInteractionEnabled = true
        exit_button.size = self.size
        exit_button.position = CGPointMake(-30, 55)
        exit_button.zPosition = 3.1
        exit_button.addChild(exit_circle)
        exit_button.addChild(x_img)
        main_scene.addChild(exit_button)
        
        let restart_img = SKSpriteNode(imageNamed: "restart_button")
        restart_img.size = CGSize(width: 24, height: 24)
        let restart_circle: SKShapeNode = outside_circle.copy() as! SKShapeNode
        restart_button = RestartButton(scene: main_scene, world: node_world, paused_button: self)
        restart_button.userInteractionEnabled = true
        restart_button.size = self.size
        restart_button.position = CGPointMake(main_scene.size.width+30, 55)
        restart_button.zPosition = 3.1
        restart_button.addChild(restart_circle)
        restart_button.addChild(restart_img)
        main_scene.addChild(restart_button)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        button_player.play()
        // Pause Or unpause the Game
        if (node_world.paused == true) {
            node_world.paused = false
            main_scene.physicsWorld.speed = 1
            background_screen.runAction(SKAction.fadeOutWithDuration(0.5))
            exit_button.runAction(SKAction.moveTo(CGPointMake(-30, 55), duration: 0.5))
            restart_button.runAction(SKAction.moveTo(CGPointMake(main_scene.size.width+30, 55), duration: 0.5))
        } else {
            node_world.paused = true
            main_scene.physicsWorld.speed = 0
            background_screen.runAction(SKAction.fadeAlphaTo(0.7, duration: 0.5))
            exit_button.runAction(SKAction.moveTo(CGPointMake(60, 55), duration: 0.5))
            restart_button.runAction(SKAction.moveTo(CGPointMake(main_scene.size.width-60, 55), duration: 0.5))
        }
        super.touchesEnded(touches, withEvent: event)
        
    }
    
}
