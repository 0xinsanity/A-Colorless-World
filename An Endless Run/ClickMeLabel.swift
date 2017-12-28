//
//  ClickMeLabel.swift
//  A Colorless World
//
//  Created by Noah Hanover on 4/28/16.
//  Copyright © 2016 Noah Hanover. All rights reserved.
//

import SpriteKit

class ClickMeLabel: SKLabelNode {
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        UIApplication.sharedApplication().openURL(NSURL(string : "itms-apps://itunes.apple.com/app/id1109926685")!)
        super.touchesBegan(touches, withEvent: event)
    }
}
