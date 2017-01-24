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
    var backgroundMusic = SoundEngine()
    let background = Background()
    let player = Player(texture: SKTextureAtlas(named: "movement").textureNamed("movement3"))
    let bullet = Bullet(imageNamed: "bullet")
    let enemy = Enemy(imageNamed: "robot")
    var floor = Border(rectOf: CGSize(width: 10000, height: 0))
    var wall = Border(rectOf: CGSize(width: 10, height: Responsive.getHeightScreen()))
    var level = CityLevel()
    let cloud = Clouds()
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
        self.physicsWorld.contactDelegate = self;
        prepareLevel()
    }
    
    func prepareLevel(){
        initBackground()
        prepareBlur()
        initLevel()
        initClouds()
        initMusic()
        initPlayer()
        initEnemy()
        initCamera()
        initController()
        initLives()
    }
    
    func initBackground(){
        // Init background
        self.backgroundColor = SKColor(red: CGFloat(169.0/255.0), green: CGFloat(212.0/255.0), blue: CGFloat(217.0/255.0), alpha: 0)
        background.load(scene: self)
        

    }
    
    func initClouds(){
        for _ in 0...20{
            cloud.move(scene: self)
        }
    }
    
    func initLevel(){
        // Init level
        floor.load(position: CGPoint(x: 0, y: 100), scene: self)
        wall.load(position: CGPoint(x: 0, y: 50), scene: self)
        level.showLives()
        
        // Save floor position globally so it can be used for calculations
        Global.floorPosition = floor.position
    }
    
    func initController(){
        // Init buttons
        controllerButtons.loadButtonRight(button: buttonRight)
        controllerButtons.loadButtonUp(button: buttonUp)
        controllerButtons.loadButtonLeft(button: buttonLeft)
        controllerButtons.loadButtonMenu(button: buttonMenu)
        buttonMenu.addTarget(self, action: #selector(ButtonUpMenu), for: .touchUpInside)
        
        // Place buttons
        view?.addSubview(buttonLeft)
        view?.addSubview(buttonRight)
        view?.addSubview(buttonUp)
        view?.addSubview(buttonMenu)

    }
    func prepareBlur(){
        blurEffectView.frame = (view?.bounds)!
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    func initLives(){
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
            view?.addSubview(liveImage)
        }
    }
    
    func initCamera(){
        // Init camera
        self.camera = cam
        cam.position.y += (self.frame.height/2)
        // calculateCamera()
    }
    
    func initMusic(){
        //Init sound
        backgroundMusic.play(scene: self)
    }
    
    func initPlayer(){
        // Init player
        player.load(scene: self)
        //Magical print statement
        print(player.framesMove)

    }
    
    func initEnemy(){
        // Init enemy
        enemy.load(scene: self)
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
        if(controllerButtons.buttonStateL == true || controllerButtons.buttonStateR == true){
            player.animateMove(l: controllerButtons.buttonStateL, r: controllerButtons.buttonStateR)
        }else{
            self.run(SKAction.run({
                self.player.moveEnded()
            }))
            
        }
        
    }
    
    func invokeFire(){
        // Start firebullet action mayfire is false till sequence is done running
        let fireBullet = SKAction.run(){
            self.enemy.fireBullet(scene: self)
            self.enemy.mayFire = false
        }
        // Enemy may only fire when sequence is done running
        let completion = SKAction.run(){
            self.enemy.mayFire = true
        }
        let waitToFireEnemyBullet = SKAction.wait(forDuration: 1.5)
        let enemyFire = SKAction.sequence([fireBullet,waitToFireEnemyBullet,completion])
        
       // Enemy may only fire when sequence is done running
        if self.enemy.mayFire == true {
            self.run(enemyFire)
        }
    }
    
    func enemyAttack(){
        enemy.moveTo(pos: player.position)
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
            initController()
            initLives()
            
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
            player.lives -= 1
        
        case PhysicsCategory.bullet | PhysicsCategory.player:
            player.lives -= 1
            
        default :
            //Some other contact has occurred
            print("Some other contact")
        }
    }
    override func update(_ currentTime: CFTimeInterval) {
        player.checkLives(scene: scene!)
        // Move to player position when in range
        enemyAttack()
        // Fire bullet when enemy is in range of player
        if enemy.inRange == true {
            invokeFire()
        }
        
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
        backgroundMusic.run(SKAction.stop())
        Global.savedPosition = CGPoint(x: 30, y: 125)
        loadScene(withIdentifier: .gameOver)
        
    }
}

