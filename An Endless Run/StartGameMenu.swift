//
//  StartGameMenu.swift
//  A Colorless World
//
//  Created by Noah Hanover on 4/25/16.
//  Copyright © 2016 Noah Hanover. All rights reserved.
//

import SpriteKit
import AVFoundation

class StartGameMenu: SKScene {
    var audio_player: AVAudioPlayer!
    var button_player: AVAudioPlayer!
    var title_game: UILabel!
    var playGameButton: UIButton!
    var instructions_button: UIButton!
    var reset_button: UIButton!
    var gray_world: UIImageView!
    var player_circle: SKShapeNode!
    var next_scene: SKScene!
    var music_btn: UIButton!
    
    struct ScreenSize
    {
        static let SCREEN_WIDTH = UIScreen.mainScreen().bounds.size.width
        static let SCREEN_HEIGHT = UIScreen.mainScreen().bounds.size.height
        static let SCREEN_MAX_LENGTH = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
        static let SCREEN_MIN_LENGTH = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    }
    struct DeviceType
    {
        static let IS_IPHONE_4_OR_LESS = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
        static let IS_IPHONE_5 = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
        static let IS_IPHONE_6 = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
        static let IS_IPHONE_6P = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
        static let IS_IPAD = UIDevice.currentDevice().userInterfaceIdiom == .Pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
    }
    
    override func didMoveToView(view: SKView) {
        
        if (AudioPlayerSingleton.sharedInstance != nil) {
            AudioPlayerSingleton.sharedInstance.stop()
        }
        
        let music_loop_url = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("title_screen", ofType: "wav")!)
        do {
            AudioPlayerSingleton.sharedInstance = try AudioPlayerSingleton(contentsOfURL: music_loop_url)
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
        } catch {
            print("Cant play")
        }
        
        audio_player = AudioPlayerSingleton.sharedInstance
        audio_player.numberOfLoops = -1
        audio_player.prepareToPlay()
        audio_player.play()
        
        let button_url = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("buttonsound_basic", ofType: "wav")!)
        do {
            button_player = try AudioPlayerSingleton(contentsOfURL: button_url)
        } catch {
            print("Cant play")
        }
        button_player.numberOfLoops = 0
        
        self.backgroundColor = SKColor.lightGrayColor()
        
        gray_world = UIImageView(image: UIImage(named: "gray_world"))
        gray_world.frame = CGRect(x: (self.view?.frame.midX)!-125, y: 90, width: 250, height: 250)
        self.view?.addSubview(gray_world)
        
        player_circle = SKShapeNode(rectOfSize: CGSize(width: 30, height: 30))
        player_circle.fillColor = SKColor.greenColor()
        player_circle.strokeColor = SKColor.blackColor()
        player_circle.position = CGPointMake((self.view?.frame.midX)!, (self.view?.frame.size.height)!-75)
        self.addChild(player_circle)
        
        title_game = UILabel()
        title_game.frame = CGRect(x: 0, y: 290, width: (self.view?.frame.size.width)!, height: 160)
        title_game.textAlignment = .Center
        title_game.text = "A Colorless World"
        title_game.textColor = SKColor.whiteColor()
        title_game.font = UIFont(name: "AmericanTypeWriter-Bold", size: 30)
        title_game.textAlignment = .Center
        title_game.font = title_game.font.fontWithSize(35)
        self.view!.addSubview(title_game)
        
        playGameButton = UIButton(type: UIButtonType.System)
        playGameButton.frame = CGRect(x: self.view!.frame.midX-80, y: self.view!.frame.maxY-220, width: 160, height: 40)
        playGameButton.backgroundColor = SKColor(red: 94/256.0, green: 94/256.0, blue: 94/256.0, alpha: 1)
        playGameButton.layer.cornerRadius = 5
        playGameButton.titleLabel!.font = UIFont(name: "AmericanTypeWriter-Bold", size: 25)
        playGameButton.setTitle("Start Game", forState: UIControlState.Normal)
        playGameButton.addTarget(self, action: #selector(playGameClick), forControlEvents: UIControlEvents.TouchUpInside)
        self.view!.addSubview(playGameButton)
        
        instructions_button = UIButton(type: UIButtonType.System)
        instructions_button.frame = CGRect(x: self.view!.frame.midX-90, y: self.view!.frame.maxY-160, width: 180, height: 40)
        instructions_button.backgroundColor = SKColor(red: 94/256.0, green: 94/256.0, blue: 94/256.0, alpha: 1)
        instructions_button.layer.cornerRadius = 5
        instructions_button.titleLabel!.font = UIFont(name: "AmericanTypeWriter-Bold", size: 25)
        instructions_button.setTitle("Instructions", forState: UIControlState.Normal)
        instructions_button.addTarget(self, action: #selector(show_instructions), forControlEvents: UIControlEvents.TouchUpInside)
        self.view!.addSubview(instructions_button)
        
        reset_button = UIButton(type: UIButtonType.System)
        reset_button.frame = CGRect(x: self.view!.frame.midX-55, y: self.view!.frame.maxY-100, width: 110, height: 40)
        reset_button.backgroundColor = SKColor(red: 94/256.0, green: 94/256.0, blue: 94/256.0, alpha: 1)
        reset_button.layer.cornerRadius = 5
        reset_button.titleLabel!.font = UIFont(name: "AmericanTypeWriter-Bold", size: 25)
        reset_button.setTitle("Reset", forState: UIControlState.Normal)
        reset_button.addTarget(self, action: #selector(reset_app), forControlEvents: UIControlEvents.TouchUpInside)
        self.view!.addSubview(reset_button)
        
        music_btn = UIButton(type: UIButtonType.System)
        music_btn.frame = CGRect(x: self.view!.frame.width-55, y: 60, width: 40, height: 40)
        
        if (AVAudioSession.sharedInstance().otherAudioPlaying) {
            NSUserDefaults.standardUserDefaults().setValue(false, forKey: "Music")
            music_btn.setImage(UIImage(named: "Music_Off"), forState: UIControlState.Normal)
        } else {
            NSUserDefaults.standardUserDefaults().setValue(true, forKey: "Music")
            music_btn.setImage(UIImage(named: "Music_On"), forState: UIControlState.Normal)
        }
        
        if (NSUserDefaults.standardUserDefaults().valueForKey("Music") != nil && NSUserDefaults.standardUserDefaults().valueForKey("Music") as! Bool == false) {
            AudioPlayerSingleton.sharedInstance.volume = 0
        }
        
        music_btn.addTarget(self, action: #selector(turn_music_off), forControlEvents: UIControlEvents.TouchUpInside)
        self.view!.addSubview(music_btn)
        
        let watched_animation = NSUserDefaults.standardUserDefaults().valueForKey("Watched Animation")
        
        if (watched_animation == nil) {
            next_scene = StoryAnimation(size: self.view!.frame.size, level: 0)
        } else {
            next_scene = PlayGameScene(level: 0, size: self.view!.frame.size)
        }
        
        if (DeviceType.IS_IPHONE_5) {
            title_game.frame = CGRect(x: 0, y: 275, width: (self.view?.frame.size.width)!, height: 160)
            title_game.font = UIFont(name: "AmericanTypeWriter-Bold", size: 29)
            playGameButton.frame = CGRect(x: self.view!.frame.midX-80, y: self.view!.frame.maxY-190, width: 160, height: 40)
            instructions_button.frame = CGRect(x: self.view!.frame.midX-90, y: self.view!.frame.maxY-130, width: 180, height: 40)
            reset_button.frame = CGRect(x: self.view!.frame.midX-55, y: self.view!.frame.maxY-70, width: 110, height: 40)
        } else if (StartGameMenu.DeviceType.IS_IPHONE_4_OR_LESS) {
            gray_world.frame = CGRect(x: (self.view?.frame.midX)!-90, y: 50, width: 180, height: 180)
            title_game.frame = CGRect(x: 0, y: 200, width: (self.view?.frame.size.width)!, height: 160)
            title_game.font = UIFont(name: "AmericanTypeWriter-Bold", size: 29)
            playGameButton.frame = CGRect(x: self.view!.frame.midX-80, y: self.view!.frame.maxY-170, width: 160, height: 40)
            instructions_button.frame = CGRect(x: self.view!.frame.midX-90, y: self.view!.frame.maxY-120, width: 180, height: 40)
            reset_button.frame = CGRect(x: self.view!.frame.midX-55, y: self.view!.frame.maxY-70, width: 110, height: 40)
        }
    }
    
    func playGameClick() {
        button_player.play()
        removeEverything()
        
        view!.presentScene(next_scene, transition: SKTransition.fadeWithDuration(1.5))
    }
    func turn_music_off() {
        if (music_btn.imageView?.image == UIImage(named: "Music_On")) {
            music_btn.setImage(UIImage(named: "Music_Off"), forState: UIControlState.Normal)
            NSUserDefaults.standardUserDefaults().setValue(false, forKey: "Music")
            AudioPlayerSingleton.sharedInstance.volume = 0
        } else {
            music_btn.setImage(UIImage(named: "Music_On"), forState: UIControlState.Normal)
            NSUserDefaults.standardUserDefaults().setValue(true, forKey: "Music")
            AudioPlayerSingleton.sharedInstance.volume = 1
        }
    }
    
    func reset_app() {
        button_player.play()
        
        removeEverything()
        NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "Level")
        NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "Level 4")
        NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "Level 8")
        NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "Level 12")
        NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "FINAL")
        view!.presentScene(StoryAnimation(size: self.view!.frame.size, level: 0), transition: SKTransition.fadeWithDuration(1.5))
        
        //UIApplication.sharedApplication().openURL(NSURL(string : "itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=\(APP_ID)&onlyLatestVersion=true&pageNumber=0&sortOrdering=1)")!)
    }
    
    func show_instructions() {
        button_player.play()
        hideEverything()
        let instructions_img = UIButton(frame: (self.view?.frame)!)
        instructions_img.adjustsImageWhenHighlighted = false
        instructions_img.setBackgroundImage(UIImage(named: "instructions_img"), forState: UIControlState.Normal)
        instructions_img.addTarget(self, action: #selector(showEverything), forControlEvents: UIControlEvents.TouchUpInside)
        self.view?.addSubview(instructions_img)
    }
    
    func showEverything(sender: AnyObject) {
        (sender as! UIButton).removeFromSuperview()
        title_game.hidden = false
        playGameButton.hidden = false
        reset_button.hidden = false
        instructions_button.hidden = false
        gray_world.hidden = false
        player_circle.hidden = false
        music_btn.hidden = false
    }
    
    func hideEverything() {
        title_game.hidden = true
        playGameButton.hidden = true
        reset_button.hidden = true
        instructions_button.hidden = true
        gray_world.hidden = true
        player_circle.hidden = true
        music_btn.hidden = true
    }
    
    func removeEverything() {
        title_game.removeFromSuperview()
        playGameButton.removeFromSuperview()
        reset_button.removeFromSuperview()
        instructions_button.removeFromSuperview()
        gray_world.removeFromSuperview()
        player_circle.removeFromParent()
        music_btn.removeFromSuperview()
    }
    
}
