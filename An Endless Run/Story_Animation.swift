//
//  Story_Animation.swift
//  An Endless Run
//
//  Created by Noah Hanover on 4/22/16.
//  Copyright © 2016 Noah Hanover. All rights reserved.
//

import SpriteKit
import AVFoundation

class StoryAnimation: SKScene {
    var watchedAnimation = false
    var first_line: SKLabelNode!
    var current_level: Int!
    var final_level = 16
    var click_me: ClickMeLabel!
    var move_on: SKLabelNode!
    
    init(size: CGSize, level: Int) {
        current_level = level
        super.init(size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
        AudioPlayerSingleton.sharedInstance.stop()
        
        let music_loop_url = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("storytime", ofType: "wav")!)
        do {
            AudioPlayerSingleton.sharedInstance = try AudioPlayerSingleton(contentsOfURL: music_loop_url)
        } catch {
            print("Cant play")
        }
        
        if (NSUserDefaults.standardUserDefaults().valueForKey("Music") != nil && NSUserDefaults.standardUserDefaults().valueForKey("Music") as! Bool == false) {
            AudioPlayerSingleton.sharedInstance.volume = 0
        }
        
        AudioPlayerSingleton.sharedInstance.numberOfLoops = -1
        AudioPlayerSingleton.sharedInstance.prepareToPlay()
        AudioPlayerSingleton.sharedInstance.play()
        
        self.backgroundColor = SKColor.whiteColor()
        first_line = SKLabelNode(fontNamed: "AmericanTypeWriter")
        first_line.position = CGPointMake((self.view?.frame.size.width)!/2, 350)
        first_line.fontSize = 15
        first_line.alpha = 0
        first_line.fontColor = SKColor.blueColor()
        //first_line.hidden = true
        self.addChild(first_line)
        
        click_me = ClickMeLabel(fontNamed: "AmericanTypeWriter-Bold")
        click_me.position = CGPointMake((self.view?.frame.size.width)!/2, 300)
        click_me.text = "Click Me To Help"
        click_me.userInteractionEnabled = true
        click_me.fontSize = 25
        click_me.alpha = 0
        click_me.fontColor = SKColor.cyanColor()
        self.addChild(click_me)
        
        move_on = SKLabelNode(fontNamed: "AmericanTypeWriter-Light")
        move_on.position = CGPointMake((self.view?.frame.size.width)!/2, 30)
        move_on.text = "(Click Anywhere To Continue)"
        move_on.fontSize = 13.5
        move_on.fontColor = SKColor.blackColor()
        self.addChild(move_on)
        
        if (StartGameMenu.DeviceType.IS_IPHONE_5 || StartGameMenu.DeviceType.IS_IPHONE_4_OR_LESS) {
            first_line.fontSize = 13
            click_me.fontSize = 18
        }
        if (current_level == 0) {
            game_start()
        } else if (current_level == 4) {
            progress_story1()
        } else if (current_level == 8) {
            progress_story2()
        } else if (current_level == 12) {
            progress_story3()
        } else if (current_level == final_level) {
            move_on.alpha = 0
            move_on.fontColor = SKColor.whiteColor()
            endStory()
        }
    }
    
    func game_start() {
        first_line.text = "There once was a world"
        first_line.runAction(SKAction.sequence([SKAction.fadeInWithDuration(1), SKAction.waitForDuration(1), SKAction.fadeOutWithDuration(1)])) {
            self.first_line.fontColor = SKColor.redColor()
            self.first_line.text = "Where colors beautified everything"
            self.first_line.runAction(SKAction.sequence([SKAction.fadeInWithDuration(1), SKAction.waitForDuration(1), SKAction.fadeOutWithDuration(1)]), completion: {
                self.first_line.fontColor = SKColor.orangeColor()
                self.first_line.text = "Everything lived in harmony"
                self.first_line.runAction(SKAction.sequence([SKAction.fadeInWithDuration(1), SKAction.waitForDuration(1), SKAction.fadeOutWithDuration(1)]), completion: {
                    self.first_line.fontColor = SKColor.blackColor()
                    self.first_line.text = "But one day, war shattered this peace"
                    self.first_line.runAction(SKAction.sequence([SKAction.fadeInWithDuration(1), SKAction.waitForDuration(1), SKAction.fadeOutWithDuration(1)]), completion: {
                        self.first_line.text = "Gray covered the once beautiful valleys"
                        self.first_line.runAction(SKAction.sequence([SKAction.fadeInWithDuration(1), SKAction.waitForDuration(1), SKAction.fadeOutWithDuration(1)]), completion: {
                            self.first_line.text = "The green square is the final hope for peace"
                            self.first_line.runAction(SKAction.sequence([SKAction.fadeInWithDuration(1), SKAction.waitForDuration(1), SKAction.fadeOutWithDuration(1)]), completion: {
                                self.move_next_scene(0)
                            })
                        })
                    })
                })
            })
        }
    }
    
    func progress_story1() {
        first_line.fontColor = SKColor(red: 219/256.0, green: 5/256.0, blue: 106/256.0, alpha: 1)
        first_line.text = "You remember her"
        first_line.runAction(SKAction.sequence([SKAction.fadeInWithDuration(1), SKAction.waitForDuration(1), SKAction.fadeOutWithDuration(1)])) {
            self.first_line.text = "Happiness fills your soul"
            self.first_line.runAction(SKAction.sequence([SKAction.fadeInWithDuration(1), SKAction.waitForDuration(1), SKAction.fadeOutWithDuration(1)]), completion: {
                self.first_line.text = "Sadness then drains it from your body"
                self.first_line.runAction(SKAction.sequence([SKAction.fadeInWithDuration(1), SKAction.waitForDuration(1), SKAction.fadeOutWithDuration(1)]), completion: {
                    self.first_line.text = "The unbearable memories are pushed aside"
                    self.first_line.runAction(SKAction.sequence([SKAction.fadeInWithDuration(1), SKAction.waitForDuration(1), SKAction.fadeOutWithDuration(1)]), completion: {
                        self.first_line.text = "The long journey cannot stop now"
                        self.first_line.runAction(SKAction.sequence([SKAction.fadeInWithDuration(1), SKAction.waitForDuration(1), SKAction.fadeOutWithDuration(1)]), completion: {
                            self.move_next_scene(4)
                        })
                    
                    })
                })
            })
        }
    }
    
    func progress_story2() {
        first_line.fontColor = SKColor(red: 62/256.0, green: 85/256.0, blue: 255/256.0, alpha: 1)
        first_line.text = "The battle seems so clear"
        first_line.runAction(SKAction.sequence([SKAction.fadeInWithDuration(1), SKAction.waitForDuration(1), SKAction.fadeOutWithDuration(1)])) {
            self.first_line.text = "A hidden square watches from afar"
            self.first_line.runAction(SKAction.sequence([SKAction.fadeInWithDuration(1), SKAction.waitForDuration(1), SKAction.fadeOutWithDuration(1)]), completion: {
                self.first_line.text = "Gray spilt everywhere"
                self.first_line.runAction(SKAction.sequence([SKAction.fadeInWithDuration(1), SKAction.waitForDuration(1), SKAction.fadeOutWithDuration(1)]), completion: {
                    self.first_line.text = "She is laughing at you"
                    self.first_line.runAction(SKAction.sequence([SKAction.fadeInWithDuration(1), SKAction.waitForDuration(1), SKAction.fadeOutWithDuration(1)]), completion: {
                        self.first_line.text = "Betrayal is laughing at you"
                        self.first_line.runAction(SKAction.sequence([SKAction.fadeInWithDuration(1), SKAction.waitForDuration(1), SKAction.fadeOutWithDuration(1)]), completion: {
                            self.move_next_scene(8)
                        })
                        
                    })
                })
            })
        }
    }
    
    func progress_story3() {
        first_line.fontColor = SKColor(red: 56/256.0, green: 95/256.0, blue: 202/256.0, alpha: 1)
        first_line.text = "With the Reds behind, you escape"
        first_line.runAction(SKAction.sequence([SKAction.fadeInWithDuration(1), SKAction.waitForDuration(1), SKAction.fadeOutWithDuration(1)])) {
            self.first_line.text = "Starving and with no hope, a shape takes you in"
            self.first_line.runAction(SKAction.sequence([SKAction.fadeInWithDuration(1), SKAction.waitForDuration(1), SKAction.fadeOutWithDuration(1)]), completion: {
                self.first_line.text = "He feeds you, trains you to survive"
                self.first_line.runAction(SKAction.sequence([SKAction.fadeInWithDuration(1), SKAction.waitForDuration(1), SKAction.fadeOutWithDuration(1)]), completion: {
                    self.first_line.text = "He protected you from her"
                    self.first_line.runAction(SKAction.sequence([SKAction.fadeInWithDuration(1), SKAction.waitForDuration(1), SKAction.fadeOutWithDuration(1)]), completion: {
                        self.first_line.text = "But betrayal is always in your mind"
                        self.first_line.runAction(SKAction.sequence([SKAction.fadeInWithDuration(1), SKAction.waitForDuration(1), SKAction.fadeOutWithDuration(1)]), completion: {
                            self.move_next_scene(12)
                        })
                        
                    })
                })
            })
        }
    }
    
    func endStory() {
        self.backgroundColor = SKColor.blackColor()
        first_line.fontColor = SKColor.greenColor()
        first_line.text = "This square's journey has not ended yet"
        first_line.runAction(SKAction.sequence([SKAction.fadeInWithDuration(1), SKAction.waitForDuration(1), SKAction.fadeOutWithDuration(1)])) {
            self.first_line.text = "But unfortunately it has for now"
            self.first_line.runAction(SKAction.sequence([SKAction.fadeInWithDuration(1), SKAction.waitForDuration(1), SKAction.fadeOutWithDuration(1)]), completion: {
                self.first_line.text = "Please help support this game"
                self.first_line.runAction(SKAction.sequence([SKAction.fadeInWithDuration(1), SKAction.waitForDuration(1), SKAction.fadeOutWithDuration(1)]), completion: {
                    self.first_line.text = "A rating is something that may seem unimportant"
                    self.first_line.runAction(SKAction.sequence([SKAction.fadeInWithDuration(1), SKAction.waitForDuration(1), SKAction.fadeOutWithDuration(1)]), completion: {
                        self.first_line.text = "But to me, it is everything"
                        self.first_line.runAction(SKAction.fadeInWithDuration(1))
                        self.click_me.runAction(SKAction.fadeInWithDuration(1))
                        self.move_on.runAction(SKAction.fadeInWithDuration(1))
                    })
                })
            })
        }
    }
    
    func move_next_scene(level_number: Int) {
        if (level_number == 0) {
            self.watchedAnimation = true
            NSUserDefaults.standardUserDefaults().setBool(self.watchedAnimation, forKey: "Watched Animation")
        } else {
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "Level \(level_number)")
        }
        AudioPlayerSingleton.sharedInstance.stop()
        let first_scene = PlayGameScene(level: 0, size: self.view!.frame.size)
        self.view!.presentScene(first_scene, transition: SKTransition.fadeWithDuration(1.5))
        self.removeFromParent()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if (move_on.fontColor! == UIColor.init(red: 1, green: 1, blue: 1, alpha: 1) && move_on.alpha == 1) {
            // CHANGE 13 FOR FINAL LEVEL
            self.removeFromParent()
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "FINAL")
            let first_scene = PlayGameScene(level: 0, size: self.view!.frame.size)
            self.view!.presentScene(first_scene, transition: SKTransition.fadeWithDuration(1.5))
            AudioPlayerSingleton.sharedInstance.stop()
            let music_loop_url = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("ingame_extended", ofType: "wav")!)
            do {
                AudioPlayerSingleton.sharedInstance = try AudioPlayerSingleton(contentsOfURL: music_loop_url)
            } catch {
                print("Cant play")
            }
            AudioPlayerSingleton.sharedInstance.numberOfLoops = -1
            AudioPlayerSingleton.sharedInstance.prepareToPlay()
            AudioPlayerSingleton.sharedInstance.play()
            
        } else if (move_on.fontColor! == UIColor.init(red: 0, green: 0, blue: 0, alpha: 1)) {
            move_next_scene(current_level)
        }
        
        super.touchesBegan(touches, withEvent: event)
    }
}
