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
    case game = "GameScene"
    case gameOver = "GameOverScene"
}

private let sceneSize = CGSize(width: Responsive().getWidthScreen(), height: Responsive().getHeightScreen())

protocol SceneManager { }
extension SceneManager where Self: SKScene {
    
    // No xCode level editor
    func loadScene(withIdentifier identifier: SceneIdentifier) {
    
        let scene: SKScene
    
        switch identifier {
    
            case .start:
                scene = StartScreenScene(size: sceneSize)
            case .game:
                scene = GameScene(size: sceneSize)
            case .gameOver:
                scene = GameOverScreenScene(size: sceneSize)
        }
    
    let transition = SKTransition.doorsOpenHorizontal(withDuration: 1)
    scene.scaleMode = .aspectFill
        view?.presentScene(scene, transition: transition)
    }
    
}
