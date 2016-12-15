//
//  GameOverScreenScene.swift
//  codeKlojo
//
//  Created by Tim Bartels on 23-11-16.
//  Copyright © 2016 Tim Bartels. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameOverScreenScene: SKScene, SceneManager {
    let textLabel = SKLabelNode()
    
    override func sceneDidLoad() {
        
    }
    
    override func didMove(to view: SKView) {
        self.backgroundColor = SKColor.black
        initText()
    }
    
    func initText(){
        textLabel.text = "Klik om overnieuw te beginnen"
        textLabel.color = UIColor.white
        textLabel.position = CGPoint(x: (Responsive.getWidthScreen()/2), y: (Responsive.getHeightScreen()/2))
        addChild(textLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        loadScene(withIdentifier: .cityscreen)
    }
    
    
    override func update(_ currentTime: CFTimeInterval) {
        
    }
}
