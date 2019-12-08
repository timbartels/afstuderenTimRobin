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
    func presentCityScreenScene()
    func presentMissionScreenScene(mission: Mission)
    func presentGameOverScreenScene()
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
    
    func presentCityScreenScene() {
        let sceneName = "CityScreenScene"
        if let cityScreenScene = SKScene(fileNamed: sceneName) as? CityScreenScene {
            cityScreenScene.sceneManagerDelegate = self
            present(scene: cityScreenScene)
        }
    }
    
    func presentMissionScreenScene(mission: Mission) {
        let missionScreenScene = MissionScreenScene()
        missionScreenScene.mission = mission
        missionScreenScene.sceneManagerDelegate = self
        present(scene: missionScreenScene)
    }
    
    func presentGameOverScreenScene() {
        let gameOverScreenScene = GameOverScreenScene()
        gameOverScreenScene.sceneManagerDelegate = self
        present(scene: gameOverScreenScene)
    }
    
    func present(scene: SKScene) {
        if let view = self.view as! SKView? {
            scene.scaleMode = .resizeFill
            view.presentScene(scene)
            view.ignoresSiblingOrder = true
        }
    }
}

