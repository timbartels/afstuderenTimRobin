//
//  StartScreenScene.swift
//  codeKlojo
//
//  Created by Robin Woudstra on 23-11-16.
//  Copyright © 2016 Tim Bartels. All rights reserved.
//

import SpriteKit
import GameplayKit
import UIKit

class StartScreenScene: SKScene, SceneManager {
    var backgroundMusic = SKAudioNode()
    
    let titleScreen = SKSpriteNode(imageNamed: "Titlescreen_Normal")
    let startButton = UIButton()
    let title = UITextField()
    let startImage = UIImage(named: "StartButton")
    
    override func sceneDidLoad() {
    }
    
    override func didMove(to view: SKView) {
        initTitle()
        initButton()
        initTitleScreen()
        initMusic()
    }
    
    func initMusic(){
        backgroundMusic = SKAudioNode(fileNamed: "chubby-cat.wav")
        self.addChild(backgroundMusic)
    }
    
    func initButton(){
        startButton.setImage(startImage, for: .normal)
        startButton.frame = CGRect(x: Responsive.getWidthScreen()/2-50, y: Responsive.getHeightScreen()/2, width: 150, height: 80)
        startButton.addTarget(self, action: #selector(ButtonDownStart), for: .touchUpInside)
        self.view!.addSubview(startButton)
    }
    
    func initTitleScreen(){
        titleScreen.anchorPoint = CGPoint(x: 0,y: 0)
        titleScreen.position = CGPoint(x: 0, y: 0)
        titleScreen.size.height = Responsive.getHeightScreen()
        titleScreen.zPosition = -99
        titleScreen.size.width = Responsive.getWidthScreen()
        self.addChild(titleScreen)
    }
    
    func initTitle(){
        title.text = "codeKlojo"
        title.textColor = UIColor.white
        title.font = UIFont(name: "Glass_TTY_VT220", size: 100)
        title.frame = CGRect(x: Responsive.getWidthScreen()/2-200, y: Responsive.getHeightScreen()/2-250, width: 500, height: 250)
        title.isUserInteractionEnabled = false
        self.view!.addSubview(title)

    }
    
    @objc func ButtonDownStart(sender:UIButton) {
        backgroundMusic.run(SKAction.stop())
        loadScene(withIdentifier: .cityscreen)
    }
    
    override func update(_ currentTime: CFTimeInterval) {
       
    }
}
