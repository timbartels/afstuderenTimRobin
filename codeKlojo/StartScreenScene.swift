//
//  StartScreenScene.swift
//  codeKlojo
//
//  Created by Robin Woudstra on 23-11-16.
//  Copyright © 2016 Tim Bartels. All rights reserved.
//

import SpriteKit
import GameplayKit

class StartScreenScene: SKScene, SceneManager {
    let textLabel = SKLabelNode(fontNamed: "Arial")
    
    override func sceneDidLoad() {
    }
    
    override func didMove(to view: SKView) {
        self.backgroundColor = SKColor(red: CGFloat(116.0/255.0), green: CGFloat(226.0/255.0), blue: CGFloat(207.0/255.0), alpha: 1)
        textLabel.text = "Raak het scherm aan om het spel te beginnen"
        textLabel.position = CGPoint(x: (Responsive().getWidthScreen()/2), y: (Responsive().getHeightScreen()/2))
        textLabel.fontSize = 22
        textLabel.zPosition = 99
        textLabel.color = UIColor.white
        addChild(textLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        loadScene(withIdentifier: .game)
    }
    
    
    override func update(_ currentTime: CFTimeInterval) {
       
    }
}
