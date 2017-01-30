//
//  SoundEngine.swift
//  codeKlojo
//
//  Created by Tim Bartels on 14-12-16.
//  Copyright © 2016 Tim Bartels. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation

class SoundEngine: SKNode{
    var mute = false
    func play(scene: SKScene){
        var music = SKAudioNode()
        if let sceneTitle = scene.name{
            switch sceneTitle{
            case "cityscreen":
                music = SKAudioNode(fileNamed: "blob-tales.wav")
            case "missionscreen":
                music = SKAudioNode(fileNamed: "find-the-exit.wav")
            case "startscreen":
                music = SKAudioNode(fileNamed: "chubby-cat.wav")
            default:
                music = SKAudioNode(fileNamed: "chubby-cat.wav")
            }
            if mute == false{
                scene.addChild(music)
            }
        }
    }
}
