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
    var backgroundMusic = SoundEngine()
    
    let titleScreen = SKSpriteNode(imageNamed: "startscreen")
    let startButton = UIButton()
    let title = UITextField()
    let startImage = UIImage(named: "StartButton")
    
    override func sceneDidLoad() {
    }
    
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
        startButton.setImage(startImage, for: .normal)
        startButton.frame = CGRect(x: Responsive.getWidthScreen()/2-150, y: Responsive.getHeightScreen()-150, width: 280, height: 100)
        startButton.addTarget(self, action: #selector(ButtonDownStart), for: .touchUpInside)
        startButton.alpha = 0.0
        
        UIView.animate(withDuration: 1.0, animations: {
            self.startButton.alpha = 1.0
        }, completion: { finished in })
        
        self.view!.addSubview(startButton)
    }
    
    func initTitleScreen(){
        titleScreen.anchorPoint = CGPoint(x: 0,y: 0)
        titleScreen.position = CGPoint(x: 0, y: -150)
        titleScreen.zPosition = -99
        titleScreen.size.width = Responsive.getWidthScreen()
        self.addChild(titleScreen)
    }
    
    @objc func ButtonDownStart(sender:UIButton) {
        backgroundMusic.run(SKAction.stop())
        loadScene(withIdentifier: .cityscreen)
    }
    
    override func update(_ currentTime: CFTimeInterval) {
       
    }
}
