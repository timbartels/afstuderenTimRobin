//
//  MissionScreenScene.swift
//  codeKlojo
//
//  Created by Tim Bartels on 12-12-16.
//  Copyright © 2016 Tim Bartels. All rights reserved.
//

import SpriteKit

class MissionScreenScene: SKScene, SceneManager {
    
    override func sceneDidLoad() {
    }
    
    override func didMove(to view: SKView) {
        // Init background
        self.backgroundColor = SKColor(red: CGFloat(116.0/255.0), green: CGFloat(226.0/255.0), blue: CGFloat(207.0/255.0), alpha: 0)
        self.addChild(Background().load().first!)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        loadScene(withIdentifier: .game)
        
    }
    
    
    override func update(_ currentTime: CFTimeInterval) {
        
    }

}
