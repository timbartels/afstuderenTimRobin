//
//  GameSceneLoader.swift
//  codeKlojo
//
//  Created by Tim Bartels on 23-11-16.
//  Copyright © 2016 Tim Bartels. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameSceneLoader: SKScene{
    func load(sceneTitle: String){
        if #available(iOS 10.0, *) {
            let scene = SKScene(fileNamed: sceneTitle)
                
                // Get the SKScene from the loaded GKScene
            
                    // Set the scale mode to scale to fit the window
                    scene?.scaleMode = .aspectFill
                    
                    // Present the scene
                    if let view = self.view {
                        
                        scene?.scaleMode = SKSceneScaleMode.resizeFill
                        
                        let fade = SKTransition.crossFade(withDuration: 1.5)
                        view.presentScene(scene!, transition: fade)
                        
                        view.ignoresSiblingOrder = true
                        view.showsFPS = true
                        view.showsNodeCount = true
                    }
                
            
        } else {
            // Fallback on earlier versions
            let scene = SKScene(fileNamed: sceneTitle)
            // Set the scale mode to scale to fit the window
            scene?.scaleMode = .aspectFill
            
            // Present the scene
            if let view = self.view {
                
                scene?.scaleMode = SKSceneScaleMode.resizeFill
                view.presentScene(scene)
                
                view.ignoresSiblingOrder = true
                view.showsFPS = true
                view.showsNodeCount = true
            }
            
        }

    }
}
