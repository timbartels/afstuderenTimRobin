//
//  StartScreenScene.swift
//  codeKlojo
//
//  Created by Robin Woudstra on 23-11-16.
//  Copyright © 2016 Tim Bartels. All rights reserved.
//

import SpriteKit
import GameplayKit

class MenuScene: SKScene {
    var sceneManagerDelegate: SceneManagerDelegate?

    var backgroundMusic = SoundEngine()
    
    let titleScreen = SKSpriteNode(imageNamed: "startscreen")
    
    override func didMove(to view: SKView) {
        initButton()
        initTitleScreen()
        initMusic()
    }
    
    func initMusic(){
        backgroundMusic.play(scene: self)  
        self.addChild(backgroundMusic)
    }
    
    func initButton(){
        let startButton = SpriteKitButton(defaultButtonImage: "start_button", action: menuButtonHandler, index: 1)
        startButton.aspectScale(to: frame.size, width: true, multiplier: 0.2)
        startButton.position = CGPoint(x: frame.size.width/2, y: frame.size.height/5)
        self.addChild(startButton)
    }
    
    func initTitleScreen(){
        titleScreen.position = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
        titleScreen.zPosition = -99
        titleScreen.aspectScale(to: frame.size, width: true, multiplier: 1.0)
        self.addChild(titleScreen)
    }
    
    func menuButtonHandler(index: Int, finished: Bool) {
        switch index {
        case 1:
            sceneManagerDelegate?.presentCityScreenScene()
        default:
            sceneManagerDelegate?.presentCityScreenScene()
        }
    }
}
