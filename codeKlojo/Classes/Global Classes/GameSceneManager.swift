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
    case gameOver = "GameOverScene"
    case ending = "EndingScene"
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
        
        var transition = SKTransition()
    
        switch identifier {
    
            case .start:
                scene = StartScreenScene(size: sceneSize)
                scene.name = "startscreen"
                let direction = SKTransitionDirection.down
                transition = SKTransition.push(with: direction, duration: 1)
            case .cityscreen:
                scene = CityScreenScene(size: sceneSize)
                scene.name = "cityscreen"
                transition = SKTransition.fade(withDuration: 1)
            case .gameOver:
                scene = GameOverScreenScene(size: sceneSize)
                let direction = SKTransitionDirection.down
                transition = SKTransition.push(with: direction, duration: 1)
            case .ending:
                scene = EndingScreenScene(size: sceneSize)
                let direction = SKTransitionDirection.down
                transition = SKTransition.push(with: direction, duration: 1)
        }
        
        
        
        view?.presentScene(scene, transition: transition)
    }
    
}
