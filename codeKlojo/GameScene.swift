//
//  GameScene.swift
//  codeKlojo
//
//  Created by Tim Bartels on 08-11-16.
//  Copyright © 2016 Tim Bartels. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    let cam = SKCameraNode()
    let player = Character(imageNamed: "player_assets")
    let background = Background(imageNamed: "background")
    let buttonRight = UIButton()
    let buttonLeft = UIButton()
    let buttons = Buttons()
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
 
    
    private var lastUpdateTime : TimeInterval = 0
    private var label : SKLabelNode?

    
    override func sceneDidLoad() {
        self.lastUpdateTime = 0
    }
 
    override func didMove(to view: SKView) {
        self.camera = cam
        background.load()
        addChild(background)
        player.load()
        addChild(player)
        buttons.loadButtonRight(button: buttonRight)
        buttons.loadButtonLeft(button: buttonLeft)
        view.addSubview(buttonLeft)
        view.addSubview(buttonRight)
        
    }
    
    func touchDown(atPoint pos : CGPoint) {

    }
    
    func touchMoved(toPoint pos : CGPoint) {
 
    }
    
    func touchUp(atPoint pos : CGPoint) {

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.touchDown(atPoint: t.location(in: self))
            // Check if the location of the touch is within the button's bounds
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func update(_ currentTime: CFTimeInterval) {
        
        cam.position = player.position
        cam.position.y += (self.frame.height/2)-100
        if (buttons.buttonStateR == true){
            player.moveRight()
        }

        if (buttons.buttonStateL == true){
            player.moveLeft()
        }
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
    }
}
