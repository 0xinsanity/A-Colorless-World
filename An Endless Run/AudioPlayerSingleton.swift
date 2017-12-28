//
//  AudioPlayerSingleton.swift
//  A Colorless World
//
//  Created by Noah Hanover on 5/12/16.
//  Copyright © 2016 Noah Hanover. All rights reserved.
//

import AVFoundation
class AudioPlayerSingleton: AVAudioPlayer {
    static var sharedInstance: AudioPlayerSingleton!
}
