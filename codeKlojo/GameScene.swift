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
    var floor = Level(rectOf: CGSize(width: 6000, height: 0))
    var wall = Level(rectOf: CGSize(width: 10, height: Responsive().getHeightScreen()))
    var level = Level()
    let buttonMenu = UIButton()
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
        let backgrounds = Background().load()
        for background in backgrounds {
            self.addChild(background)
        }
        
        // Init level
        floor.loadFloor()
        wall.loadWall()
        level.showLives()
        self.addChild(level)
        self.addChild(wall)
        self.addChild(floor)
        
        // Init player
        player.load()
        addChild(player)
        
        // Init buttons
        buttons.loadButtonRight(button: buttonRight)
        buttons.loadButtonUp(button: buttonUp)
        buttons.loadButtonLeft(button: buttonLeft)
        buttons.loadButtonMenu(button: buttonMenu)
        buttonMenu.addTarget(self, action: #selector(ButtonUpMenu), for: .touchUpInside)
        
        // Place buttons
        view.addSubview(buttonLeft)
        view.addSubview(buttonRight)
        view.addSubview(buttonUp)
        view.addSubview(buttonMenu)
        
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
    
    @objc func ButtonUpMenu(sender:UIButton) {
        for view in (self.view?.subviews)!{
            view.removeFromSuperview()
        }
        loadScene(withIdentifier: .start)
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
    
    func calculateCamera(){
        //Calculate position when player reaches half of screen
        if player.position.x > self.frame.width/2{
            cam.position = player.position
        }else{
            cam.position = CGPoint(x: self.frame.width/2, y: player.position.y)
        }
        cam.position.y += (self.frame.height/2)-100
    }
    
    func checkButtonState(){
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

    }
    override func update(_ currentTime: CFTimeInterval) {
        player.checkLives()
        
        // Check for checkpoint
        if Checkpoint().check(playerPosition: player.position){
            for view in (self.view?.subviews)! {
                view.removeFromSuperview()
            }
            //Saves the current player position
            Global.savedPosition = player.position
            loadScene(withIdentifier: .mission)
        }
        
        // Remove life image
        if (player.lives > 0){
            for _ in 1...3 {
                view?.viewWithTag(player.lives+1)?.alpha = 0.7
            }
        }
        
        // Gameover
        if (player.lives == 0){
            // Reset lives
            player.lives = 3
            goToGameOverScreenScene()
        }
        
        calculateCamera()
        
        checkButtonState()
        
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
        Global.savedPosition = CGPoint(x: 0, y: 100)
        loadScene(withIdentifier: .gameOver)
        
    }
}

