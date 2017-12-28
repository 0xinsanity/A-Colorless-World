//
//  RestartButton.swift
//  A Colorless World
//
//  Created by Noah Hanover on 4/24/16.
//  Copyright © 2016 Noah Hanover. All rights reserved.
//

import SpriteKit
import AVFoundation

class RestartButton: SKSpriteNode {
    var main_scene: PlayGameScene!
    var node_world: SKNode!
    var pausedButton: PausedButton!
    var button_player: AVAudioPlayer!
    
    init(scene: PlayGameScene, world: SKNode, paused_button: PausedButton) {
        super.init(texture: nil, color: UIColor.clearColor(), size: CGSizeMake(32, 32))
        
        
        let button_url = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("buttonsound_basic", ofType: "wav")!)
        do {
            button_player = try AudioPlayerSingleton(contentsOfURL: button_url)
        } catch {
            print("Cant play")
        }
        button_player.numberOfLoops = 0
        
        node_world = world
        main_scene = scene
        pausedButton = paused_button
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        button_player.play()
        node_world.paused = false
        main_scene.physicsWorld.speed = 1
        pausedButton.background_screen.runAction(SKAction.fadeOutWithDuration(0.5))
        pausedButton.exit_button.runAction(SKAction.moveTo(CGPointMake(-30, 55), duration: 0.5))
        self.runAction(SKAction.moveTo(CGPointMake(main_scene.size.width+30, 55), duration: 0.5))
        main_scene.restartLevel()
    }
}