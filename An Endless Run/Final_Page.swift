//
//  Final_Page.swift
//  A Colorless World
//
//  Created by Noah Hanover on 4/26/16.
//  Copyright © 2016 Noah Hanover. All rights reserved.
//

import SpriteKit
import AVFoundation

class FinalPage: SKScene {
    var button_view: UIView!
    var button_player: AVAudioPlayer!
    
    override func didMoveToView(view: SKView) {
        
        let button_url = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("buttonsound_basic", ofType: "wav")!)
        do {
            button_player = try AudioPlayerSingleton(contentsOfURL: button_url)
        } catch {
            print("Cant play")
        }
        button_player.numberOfLoops = 0
        
        
        button_view = UIView(frame: (self.view?.frame)!)
        self.view?.addSubview(button_view)
        
        let button_width = ((self.view?.frame.size.width)!/3)-20
        let button_height = ((self.view?.frame.size.height)!/4)-40
        
        self.backgroundColor = SKColor.lightGrayColor()
        
        let back_button = UIButton(type: UIButtonType.RoundedRect)
        back_button.setTitle("Back", forState: UIControlState.Normal)
        back_button.backgroundColor = SKColor.darkGrayColor()
        back_button.frame = CGRect(x: 10, y: 53, width: 60, height: 30)
        back_button.titleLabel?.font = UIFont(name: "AmericanTypeWriter", size: 20)
        back_button.addTarget(self, action: #selector(goBack), forControlEvents: UIControlEvents.TouchUpInside)
        self.button_view.addSubview(back_button)
        
        // First Row
        let basis_button = UIButton(type: UIButtonType.System)
        basis_button.frame = CGRect(x: 10, y: 90, width: button_width, height: button_height)
        basis_button.backgroundColor = SKColor.darkGrayColor()
        basis_button.titleLabel?.font = UIFont(name: "AmericanTypeWriter-Bold", size: 40)
        basis_button.setTitle("1", forState: UIControlState.Normal)
        basis_button.addTarget(self, action: #selector(goToLevel), forControlEvents: UIControlEvents.TouchUpInside)
        self.button_view.addSubview(basis_button)
        
        let button_2 = NSKeyedUnarchiver.unarchiveObjectWithData(NSKeyedArchiver.archivedDataWithRootObject(basis_button)) as! UIButton
        button_2.setTitle("2", forState: UIControlState.Normal)
        button_2.frame = CGRect(x: (self.view?.frame.size.width)!/2-(button_width/2), y: 90, width: button_width, height: button_height)
        button_2.addTarget(self, action: #selector(goToLevel), forControlEvents: UIControlEvents.TouchUpInside)
        self.button_view.addSubview(button_2)
        
        let button_3 = NSKeyedUnarchiver.unarchiveObjectWithData(NSKeyedArchiver.archivedDataWithRootObject(basis_button)) as! UIButton
        button_3.setTitle("3", forState: UIControlState.Normal)
        button_3.frame = CGRect(x: (self.view?.frame.width)!-button_width-10, y: 90, width: button_width, height: button_height)
        button_3.addTarget(self, action: #selector(goToLevel), forControlEvents: UIControlEvents.TouchUpInside)
        self.button_view.addSubview(button_3)
        
        // New Row
        let button_4 = NSKeyedUnarchiver.unarchiveObjectWithData(NSKeyedArchiver.archivedDataWithRootObject(basis_button)) as! UIButton
        button_4.setTitle("4", forState: UIControlState.Normal)
        button_4.frame = CGRect(x: 10, y: (button_height)+110, width: button_width, height: button_height)
        button_4.addTarget(self, action: #selector(goToLevel), forControlEvents: UIControlEvents.TouchUpInside)
        self.button_view.addSubview(button_4)
        
        let button_5 = NSKeyedUnarchiver.unarchiveObjectWithData(NSKeyedArchiver.archivedDataWithRootObject(basis_button)) as! UIButton
        button_5.setTitle("5", forState: UIControlState.Normal)
        button_5.frame = CGRect(x: (self.view?.frame.size.width)!/2-(button_width/2), y: (button_height)+110, width: button_width, height: button_height)
        button_5.addTarget(self, action: #selector(goToLevel), forControlEvents: UIControlEvents.TouchUpInside)
        self.button_view.addSubview(button_5)
        
        let button_6 = NSKeyedUnarchiver.unarchiveObjectWithData(NSKeyedArchiver.archivedDataWithRootObject(basis_button)) as! UIButton
        button_6.setTitle("6", forState: UIControlState.Normal)
        button_6.frame = CGRect(x: (self.view?.frame.width)!-button_width-10, y: (button_height)+110, width: button_width, height: button_height)
        button_6.addTarget(self, action: #selector(goToLevel), forControlEvents: UIControlEvents.TouchUpInside)
        self.button_view.addSubview(button_6)
        
        // New Row
        let button_7 = NSKeyedUnarchiver.unarchiveObjectWithData(NSKeyedArchiver.archivedDataWithRootObject(basis_button)) as! UIButton
        button_7.setTitle("7", forState: UIControlState.Normal)
        button_7.frame = CGRect(x: 10, y: (button_height*2)+130, width: button_width, height: button_height)
        button_7.addTarget(self, action: #selector(goToLevel), forControlEvents: UIControlEvents.TouchUpInside)
        self.button_view.addSubview(button_7)
        
        let button_8 = NSKeyedUnarchiver.unarchiveObjectWithData(NSKeyedArchiver.archivedDataWithRootObject(basis_button)) as! UIButton
        button_8.setTitle("8", forState: UIControlState.Normal)
        button_8.frame = CGRect(x: (self.view?.frame.size.width)!/2-(button_width/2), y: (button_height*2)+130, width: button_width, height: button_height)
        button_8.addTarget(self, action: #selector(goToLevel), forControlEvents: UIControlEvents.TouchUpInside)
        self.button_view.addSubview(button_8)
        
        let button_9 = NSKeyedUnarchiver.unarchiveObjectWithData(NSKeyedArchiver.archivedDataWithRootObject(basis_button)) as! UIButton
        button_9.setTitle("9", forState: UIControlState.Normal)
        button_9.frame = CGRect(x: (self.view?.frame.width)!-button_width-10, y: (button_height*2)+130, width: button_width, height: button_height)
        button_9.addTarget(self, action: #selector(goToLevel), forControlEvents: UIControlEvents.TouchUpInside)
        self.button_view.addSubview(button_9)
        
        // New Row
        let button_10 = NSKeyedUnarchiver.unarchiveObjectWithData(NSKeyedArchiver.archivedDataWithRootObject(basis_button)) as! UIButton
        button_10.setTitle("10", forState: UIControlState.Normal)
        button_10.frame = CGRect(x: 10, y: (button_height*3)+150, width: button_width, height: button_height)
        button_10.addTarget(self, action: #selector(goToLevel), forControlEvents: UIControlEvents.TouchUpInside)
        self.button_view.addSubview(button_10)
        
        let button_11 = NSKeyedUnarchiver.unarchiveObjectWithData(NSKeyedArchiver.archivedDataWithRootObject(basis_button)) as! UIButton
        button_11.setTitle("11", forState: UIControlState.Normal)
        button_11.frame = CGRect(x: (self.view?.frame.size.width)!/2-(button_width/2), y: (button_height*3)+150, width: button_width, height: button_height)
        button_11.addTarget(self, action: #selector(goToLevel), forControlEvents: UIControlEvents.TouchUpInside)
        self.button_view.addSubview(button_11)
        
        let button_12 = NSKeyedUnarchiver.unarchiveObjectWithData(NSKeyedArchiver.archivedDataWithRootObject(basis_button)) as! UIButton
        button_12.setTitle("12", forState: UIControlState.Normal)
        button_12.frame = CGRect(x: (self.view?.frame.width)!-button_width-10, y: (button_height*3)+150, width: button_width, height: button_height)
        button_12.addTarget(self, action: #selector(goToLevel), forControlEvents: UIControlEvents.TouchUpInside)
        self.button_view.addSubview(button_12)
        
        super.didMoveToView(view)
    }
    
    func goToLevel(sender: AnyObject!) {
        button_player.play()
        let button = sender as! UIButton
        let level = Int((button.titleLabel?.text)!)!
        button_view.removeFromSuperview()
        let game = PlayGameScene(level: level, size: (self.view?.frame.size)!)
        self.view?.presentScene(game, transition: SKTransition.fadeWithDuration(3))
        //AudioPlayerSingleton.sharedInstance.stop()
    }
    
    func goBack() {
        button_player.play()
        button_view.removeFromSuperview()
        self.view?.presentScene(StartGameMenu(size: (self.view?.frame.size)!))
    }
}
