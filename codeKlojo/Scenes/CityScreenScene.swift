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
    let widthLevel = 15000
    let cam = SKCameraNode()
    var backgroundMusic = SoundEngine()
    let background = Background()
    let player = Player(texture: SKTextureAtlas(named: "movement").textureNamed("movement1"))
    let bullet = Bullet(imageNamed: "bullet")
    let enemy = Enemy(imageNamed: "robot")
    var wall = Border(rectOf: CGSize(width: 10, height: Responsive.getHeightScreen()))
    var level = CityLevel()
    let clouds = Clouds()
    let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.dark))
    let menuButtons = MenuButtons()
    let startButton = UIButton()
    let muteButton = UIButton()
    let resumeButton = UIButton()
    let buttonMenu = UIButton()
    let buttonRight = UIButton()
    let buttonLeft = UIButton()
    let buttonUp = UIButton()
    let buttonAttack = UIButton()
    let controllerButtons = ControllerButtons()
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    private var lastUpdateTime : TimeInterval = 0
    private var label : SKLabelNode?

    
    override func sceneDidLoad() {
        self.lastUpdateTime = 0
    }
 
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self;
        prepareLevel()
    }
    
    func prepareLevel(){
        initBackground()
        prepareBlur()
        initLevel()
        initPlatforms()
        clouds.load(scene: self, amount: 20)
        backgroundMusic.play(scene: self)
        player.load(scene: self)
        //Magical print statement
        print(player.framesMove)
        enemy.load(scene: self)
        initCamera()
        initController()
        player.initLives(view: view!)
    }
    
    func initBackground(){
        // Init background
        self.backgroundColor = SKColor(red: CGFloat(188.0/255.0), green: CGFloat(228.0/255.0), blue: CGFloat(227.0/255.0), alpha: 0)
        background.load(scene: self)
    }
    
    func initLevel(){
        let floor = Border(rectOf: CGSize(width: widthLevel, height: 0))
        // Init level
        floor.load(position: CGPoint(x: widthLevel/2, y: 100), scene: self)
        wall.load(position: CGPoint(x: 0, y: 50), scene: self)
        
        // Save floor position globally so it can be used for calculations
        Global.floorPosition = floor.position
    }
    
    func initPlatforms(){
        Platform().load()
        Platform().placePlatforms(scene: self)
    }
    
    
    func initController(){
        // Init buttons
        controllerButtons.loadButtonRight(button: buttonRight, view: view!)
        controllerButtons.loadButtonUp(button: buttonUp, view: view!)
        controllerButtons.loadButtonAttack(button: buttonAttack, view: view!)
        controllerButtons.loadButtonLeft(button: buttonLeft, view: view!)
        controllerButtons.loadButtonMenu(button: buttonMenu, view: view!)
        buttonMenu.addTarget(self, action: #selector(ButtonUpMenu), for: .touchUpInside)
    }
    func prepareBlur(){
        blurEffectView.frame = (view?.bounds)!
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
        
    func initCamera(){
        // Init camera
        self.camera = cam
        cam.position.y += (self.frame.height/2)
    }

    
    func calculateCamera(){
        //Calculate position when player reaches half of screen
        if player.position.x > self.frame.width/2{
            cam.position.x = player.position.x
           
        }else{
            cam.position.x = self.frame.width/2
        }
        
    }
    
    func checkButtonState(){
        if (controllerButtons.buttonStateU == true){
            player.jump()
            controllerButtons.buttonStateU = false
        }
        if (controllerButtons.buttonStateAttack == true){
            player.attack()
            controllerButtons.buttonStateAttack = false
        }
        if(controllerButtons.buttonStateL == true || controllerButtons.buttonStateR == true){
            player.animateMove(l: controllerButtons.buttonStateL, r: controllerButtons.buttonStateR)
        }else{
            self.run(SKAction.run({
                self.player.moveEnded()
            }))
            
        }
        
    }
    
    func enemyAttack(){
        // Move to player position when in range
        enemy.moveTo(pos: player.position)
        // Fire bullet when enemy is in range of player
        if enemy.inRange == true {
            enemy.invokeFire(scene: self)
        }
    }
   
    func checkGameOver(){
        // Gameover
        if (player.lives == 0){
            // Reset lives
            player.lives = 3
            goToGameOverScreenScene()
        }

    }
    
    func touchDown(atPoint pos : CGPoint) {

    }
    
    func touchUp(atPoint pos : CGPoint) {

    }

    @objc func ButtonUpMenu(sender:UIButton) {
        for view in (self.view?.subviews)!{
            view.removeFromSuperview()
        }
        view?.addSubview(blurEffectView)
        
        if scene?.view?.isPaused == false{
            scene?.view?.isPaused = true
            menuButtons.loadMuteButton(button: muteButton, view: view!)
            menuButtons.loadStartButton(button: startButton, view: view!)
            menuButtons.loadResumeButton(button: resumeButton, view: view!)
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
            initController()
            player.initLives(view: view!)
            
        }
        
    }
    
    @objc func MuteButton(sender: UIButton) {
        if backgroundMusic.mute == false{
            backgroundMusic.mute = true
        }else{
            backgroundMusic.mute = false
        }
    }
    
    @objc func StartButton(sender: UIButton) {
        // Remove subview elements
        for view in (self.view?.subviews)! {
            view.removeFromSuperview()
        }
        backgroundMusic.run(SKAction.stop())
        Global.savedPosition = CGPoint(x: 30, y: 125)
        scene?.view?.isPaused = false
        loadScene(withIdentifier: .start)

    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.touchDown(atPoint: t.location(in: self))
            // Check if the location of the touch is within the button's bounds
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        switch contactMask {
        case PhysicsCategory.enemy | PhysicsCategory.player:
            player.lives -= 0
        
        case PhysicsCategory.bullet | PhysicsCategory.player:
            bullet.removeFromParent()
            player.lives -= 0
            
        default :
            //Some other contact has occurred
            print("")
        }
    }
    
    override func update(_ currentTime: CFTimeInterval) {
        // Called before each frame is rendered
        enemyAttack()
        player.removeLive(view: view!)
        checkGameOver()
        calculateCamera()
        checkButtonState()
        player.checkLives(scene: scene!)
        
        //print(player.position)
        
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
        backgroundMusic.run(SKAction.stop())
        Global.savedPosition = CGPoint(x: 30, y: 125)
        loadScene(withIdentifier: .gameOver)
        
    }
}

