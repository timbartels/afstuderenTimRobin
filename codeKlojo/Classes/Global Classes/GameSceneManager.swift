//
//  GameSceneManager.swift
//  codeKlojo
//
//  Created by Tim Bartels on 23-11-16.
//  Copyright © 2016 Tim Bartels. All rights reserved.
//

import SpriteKit
import GameplayKit

enum SceneIdentifier: String {
    case start = "StartScene"
    case cityscreen = "CityScreenScene"
    case mission = "MissionScreenScene"
    case gameOver = "GameOverScene"
}

private let sceneSize = CGSize(width: Responsive.getWidthScreen(), height: Responsive.getHeightScreen())

protocol SceneManager { }
extension SceneManager where Self: SKScene {
    
    // No xCode level editor
    func loadScene(withIdentifier identifier: SceneIdentifier) {
        for view in (self.view?.subviews)!{
            view.removeFromSuperview()
        }
        let scene: SKScene
    
        switch identifier {
    
            case .start:
                scene = StartScreenScene(size: sceneSize)
            case .cityscreen:
                scene = CityScreenScene(size: sceneSize)
            case .mission:
                scene = MissionScreenScene(size: sceneSize)
            case .gameOver:
                scene = GameOverScreenScene(size: sceneSize)
        }
    
        let transition = SKTransition.doorsOpenHorizontal(withDuration: 1)
        scene.scaleMode = .aspectFill
        
        view?.presentScene(scene, transition: transition)
    }
    
}
