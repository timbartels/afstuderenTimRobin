//
//  GameScene.swift
//  codeKlojo
//
//  Created by Tim Bartels on 08-11-16.
//  Copyright © 2016 Tim Bartels. All rights reserved.
//

import SpriteKit
import GameplayKit

class CityScreenScene: SKScene, SKPhysicsContactDelegate, SceneManager {
    var mute = false
    let cam = SKCameraNode()
    var backgroundMusic = SKAudioNode()
    let player = Player(texture: SKTextureAtlas(named: "movement").textureNamed("movement3"))
    var floor = Border(rectOf: CGSize(width: 6000, height: 0))
    var wall = Border(rectOf: CGSize(width: 10, height: Responsive.getHeightScreen()))
    var level = CityLevel()
    let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.dark))
    let menuButtons = MenuButtons()
    let startButton = UIButton()
    let muteButton = UIButton()
    let resumeButton = UIButton()
    let buttonMenu = UIButton()
    let buttonRight = UIButton()
    let buttonLeft = UIButton()
    let buttonUp = UIButton()
    let controllerButtons = ControllerButtons()
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    private var lastUpdateTime : TimeInterval = 0
    private var label : SKLabelNode?

    
    override func sceneDidLoad() {
        self.lastUpdateTime = 0
    }
 
    override func didMove(to view: SKView) {
        //Init sound
        backgroundMusic = SKAudioNode(fileNamed: "blob-tales.wav")
        self.addChild(backgroundMusic)
        // Init camera
        self.camera = cam
        
        // Init background
        self.backgroundColor = SKColor(red: CGFloat(116.0/255.0), green: CGFloat(226.0/255.0), blue: CGFloat(207.0/255.0), alpha: 0)
        let backgrounds = Background().load()
        for background in backgrounds {
            self.addChild(background)
        }
        
        blurEffectView.frame = (view.bounds)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.alpha = 0.5

        // Init level
        floor.load(position: CGPoint(x: 0, y: 50))
        wall.load(position: CGPoint(x: 0, y: 50))
        level.showLives()
        self.addChild(wall)
        self.addChild(floor)
        
        // Init player
        player.load()
        addChild(player)
        
        // Init buttons
        controllerButtons.loadButtonRight(button: buttonRight)
        controllerButtons.loadButtonUp(button: buttonUp)
        controllerButtons.loadButtonLeft(button: buttonLeft)
        controllerButtons.loadButtonMenu(button: buttonMenu)
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
    
    func touchUp(atPoint pos : CGPoint) {

    }

    @objc func ButtonUpMenu(sender:UIButton) {
        view?.addSubview(blurEffectView)
        
        if scene?.view?.isPaused == false{
            scene?.view?.isPaused = true
            menuButtons.loadMuteButton(button: muteButton)
            menuButtons.loadStartButton(button: startButton)
            menuButtons.loadResumeButton(button: resumeButton)
            view?.addSubview(muteButton)
            view?.addSubview(startButton)
            view?.addSubview(resumeButton)
            resumeButton.addTarget(self, action: #selector(ResumeButton), for: .touchUpInside)
            startButton.addTarget(self, action: #selector(StartButton), for: .touchUpInside)
            muteButton.addTarget(self, action: #selector(MuteButton), for: .touchUpInside)
            
        }else{
            scene?.view?.isPaused = false

        }

    }
    
    @objc func ResumeButton(sender: UIButton) {
        if scene?.view?.isPaused == true{
            scene?.view?.isPaused = false
            muteButton.removeFromSuperview()
            startButton.removeFromSuperview()
            resumeButton.removeFromSuperview()
            blurEffectView.removeFromSuperview()
        }
        
    }
    
    @objc func MuteButton(sender: UIButton) {
        if mute == false{
            mute = true
            backgroundMusic.run(SKAction.pause())
        }else{
            mute = false
            backgroundMusic.run(SKAction.play())
        }
    }
    
    @objc func StartButton(sender: UIButton) {
        // Remove subview elements
        for view in (self.view?.subviews)! {
            view.removeFromSuperview()
        }
        backgroundMusic.run(SKAction.stop())
        Global.savedPosition = CGPoint(x: 0, y: 100)
        loadScene(withIdentifier: .start)

    }


    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.touchDown(atPoint: t.location(in: self))
            // Check if the location of the touch is within the button's bounds
        }
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
        if (controllerButtons.buttonStateU == true){
            player.jump()
            controllerButtons.buttonStateU = false
        }
        if(controllerButtons.buttonStateL == true || controllerButtons.buttonStateR == true){
            player.animateMove(l: controllerButtons.buttonStateL, r: controllerButtons.buttonStateR)
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
            backgroundMusic.run(SKAction.stop())
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
        backgroundMusic.run(SKAction.stop())
        Global.savedPosition = CGPoint(x: 0, y: 100)
        loadScene(withIdentifier: .gameOver)
        
    }
}

