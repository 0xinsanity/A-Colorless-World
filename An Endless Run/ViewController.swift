//
//  ViewController.swift
//  An Endless Run
//
//  Created by Noah Hanover on 4/4/16.
//  Copyright © 2016 Noah Hanover. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation
import GoogleMobileAds

class MenuViewController: UIViewController, GADBannerViewDelegate {
    var banner_ads: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let mainView = SKView(frame: self.view.frame)
        /*mainView.showsNodeCount = true
        mainView.showsFPS = true
        mainView.showsDrawCount = true*/
        view = mainView
        
        let game = StartGameMenu(size: self.view.frame.size)
        (view as! SKView).presentScene(game)
        
        banner_ads = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        banner_ads.adUnitID = "ca-app-pub-8777121736512556/4594500425"
        banner_ads.rootViewController = self
        banner_ads.delegate = self
        let request = GADRequest()
        //request.testDevices = ["d0b3ead5ca64796bd0a5270efc80c169"]
        banner_ads.loadRequest(request)
        self.view.addSubview(banner_ads)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}

