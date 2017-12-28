//
//  ExitButton.swift
//  A Colorless World
//
//  Created by Noah Hanover on 4/24/16.
//  Copyright © 2016 Noah Hanover. All rights reserved.
//

import SpriteKit
import AVFoundation

class ExitButton: SKSpriteNode {
    var main_scene: PlayGameScene!
    var menu_scene: StartGameMenu!
    var button_player: AVAudioPlayer!
    
    init(scene: PlayGameScene) {
        super.init(texture: nil, color: UIColor.clearColor(), size: CGSizeMake(32, 32))
        main_scene = scene
        menu_scene = StartGameMenu(size: self.main_scene.size)
        
        let button_url = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("buttonsound_basic", ofType: "wav")!)
        do {
            button_player = try AudioPlayerSingleton(contentsOfURL: button_url)
        } catch {
            print("Cant play")
        }
        button_player.numberOfLoops = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        button_player.play()
        main_scene.runAction(SKAction.fadeOutWithDuration(1.5)) {
            self.main_scene.view?.presentScene(self.menu_scene)
        }
    }
}
