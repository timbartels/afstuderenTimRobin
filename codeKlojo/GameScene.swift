//
//  GameScene.swift
//  codeKlojo
//
//  Created by Tim Bartels on 08-11-16.
//  Copyright © 2016 Tim Bartels. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate, SceneManager {
    let cam = SKCameraNode()
    let player = Player(texture: SKTextureAtlas(named: "movement").textureNamed("movement3"))
    var level = Level(rectOf: CGSize(width: 6000, height: 0))
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
        // Init camera
        self.camera = cam
        
        // Init background
        self.backgroundColor = SKColor(red: CGFloat(116.0/255.0), green: CGFloat(226.0/255.0), blue: CGFloat(207.0/255.0), alpha: 0)
        // self.addChild(Background().bg)
        let backgrounds = Background().load()
        for background in backgrounds {
            self.addChild(background)
        }
        
        // Init level
        level.loadFloor()
        level.showLives()
        self.addChild(level)
        
        // Init player
        player.load()
        player.loadLives()
        addChild(player)
        
        // Init buttons
        buttons.loadButtonRight(button: buttonRight)
        buttons.loadButtonUp(button: buttonUp)
        buttons.loadButtonLeft(button: buttonLeft)
        
        // Place buttons
        view.addSubview(buttonLeft)
        view.addSubview(buttonRight)
        view.addSubview(buttonUp)
        
        // Add lives
        let imageName = "live.png"
        let image = UIImage(named: imageName)!
        var livePosition : CGFloat = 0
        
        for i in 1...3{
            let liveImage = UIImageView(image: image)
            liveImage.tag = i
            liveImage.frame = CGRect(x: livePosition+60, y: 20, width: 50, height: 50)
            livePosition += 60
            liveImage.alpha = 1
            view.addSubview(liveImage)
        }
        
       

        
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
        player.checkLives()
        
        // Check for checkpoint
        if Checkpoint().check(playerPosition: player.position){
            for view in (self.view?.subviews)! {
                view.removeFromSuperview()
            }
            Global.savedPosition = player.position
            loadScene(withIdentifier: .mission)
        }
        
        // Remove life image
        if (player.lives > 0){
            for i in 1...3 {
                view?.viewWithTag(player.lives+1)?.alpha = 0.7
            }
        }
        
        // Gameover
        if (player.lives == 0){
            // Reset lives
            player.lives = 3
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
        // Remove subview elements
        for view in (self.view?.subviews)! {
            view.removeFromSuperview()
        }
        loadScene(withIdentifier: .gameOver)
        
    }
}

