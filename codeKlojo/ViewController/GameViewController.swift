//
//  GameViewController.swift
//  codeKlojo
//
//  Created by Tim Bartels on 08-11-16.
//  Copyright © 2016 Tim Bartels. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

protocol SceneManagerDelegate {
    func presentMenuScene()
    func presentLevelScene()
    func presentCityScreenScene()
}

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        presentMenuScene()
    }
}

extension GameViewController: SceneManagerDelegate {
    func presentMenuScene() {
        let menuScene = MenuScene()
        menuScene.sceneManagerDelegate = self
        present(scene: menuScene)
    }
    
    func presentLevelScene() {
       
    }
    
    func presentCityScreenScene() {
        let sceneName = "CityScreenScene"
        if let cityScreenScene = SKScene(fileNamed: sceneName) as? CityScreenScene {
            cityScreenScene.sceneManagerDelegate = self
            present(scene: cityScreenScene)
        }
    }
    
    func present(scene: SKScene) {
        if let view = self.view as! SKView? {
            scene.scaleMode = .resizeFill
            view.presentScene(scene)
            view.ignoresSiblingOrder = true
        }
    }
}

