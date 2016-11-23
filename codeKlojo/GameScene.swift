//
//  GameScene.swift
//  codeKlojo
//
//  Created by Tim Bartels on 08-11-16.
//  Copyright © 2016 Tim Bartels. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    let cam = SKCameraNode()
    let player = Player(texture: SKTextureAtlas(named: "movement").textureNamed("movement3"))
    var level = Level(rectOf: CGSize(width: 4000, height: 0))
    let background = Background(imageNamed: "background")
    let buttonRight = UIButton()
    let buttonLeft = UIButton()
    let buttonUp = UIButton()
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
        level.loadFloor()
        level.showLives()
        print(player.gameover)
        self.addChild(level)
        player.load()
        addChild(player)
        buttons.loadButtonRight(button: buttonRight)
        buttons.loadButtonUp(button: buttonUp)
        buttons.loadButtonLeft(button: buttonLeft)
        view.addSubview(buttonLeft)
        view.addSubview(buttonRight)
        view.addSubview(buttonUp)
        
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
        player.checkGameOver()
        if (player.gameover == 3){
            goToGameOverScreenScene()
        }
        cam.position = player.position
        cam.position.y += (self.frame.height/2)-100
        if (buttons.buttonStateU == true){
            player.jump()
            buttons.buttonStateU = false
        }
        if(buttons.buttonStateL == true || buttons.buttonStateR == true){
            player.animateMove(l: buttons.buttonStateL, r: buttons.buttonStateR)
        }else{
            self.run(SKAction.run({
                self.player.moveEnded()
            }))
            
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
    
    func goToGameOverScreenScene(){
        if #available(iOS 10.0, *) {
            if let scene = GKScene(fileNamed: "GameOverScreenScene") {
                
                // Get the SKScene from the loaded GKScene
                if let sceneNode = scene.rootNode as! GameOverScreenScene? {
           
                    
                    // Set the scale mode to scale to fit the window
                    sceneNode.scaleMode = .aspectFill
                    
                    // Present the scene
                    if let view = self.view {
                        
                        sceneNode.scaleMode = SKSceneScaleMode.resizeFill
                        
                        let fade = SKTransition.crossFade(withDuration: 1.5)
                        view.presentScene(sceneNode, transition: fade)
                        
                        view.ignoresSiblingOrder = true
                        view.showsFPS = true
                        view.showsNodeCount = true
                    }
                }
        } else {
            // Fallback on earlier versions
        }
        
    }
}
}
