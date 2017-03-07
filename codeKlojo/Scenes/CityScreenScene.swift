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
    let enemy = Enemy(imageNamed: "robot.png")
    let enemy2 = Enemy(imageNamed: "robot.png")
    let bullet = Bullet(imageNamed: "bullet")
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
    let knop = UIButton()
    let popupbox = UIView()
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
        clouds.load(scene: self, amount: 30)
        backgroundMusic.play(scene: self)
        player.load(scene: self)
        //Magical print statement
        print(player.framesMove)
        initEnemies()
        initCamera()
        initController()
        player.initLives(view: view!)
    }
    
    func initBackground(){
        // Init background
        self.backgroundColor = SKColor(red: CGFloat(188.0/255.0), green: CGFloat(228.0/255.0), blue: CGFloat(227.0/255.0), alpha: 0)
        background.load(scene: self)
    }
    func initEnemies(){
        enemy.load(scene: self)
        enemy2.load(scene: self)
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
        case PhysicsCategory.player | PhysicsCategory.enemy:
            print("collision")
            if player.attackState{
                enemy.removeFromParent()
            }else{
              player.lives -= 1
            }
        
        case PhysicsCategory.bullet | PhysicsCategory.player:
            bullet.removeFromParent()
            player.lives -= 1
            
        default :
            //Some other contact has occurred
            print("Something went wrong in the enemy/bullet collision")
        }
    }
    
    
    func calculatePlatforms(){
        
    // playerposition at player feet
    let playersize = player.size.height/2
    let playerpos = player.position.y-playersize
        
        // Loop throught all platforms every frame
        for (index, object) in Platforms.enumerated() {
            
            // Create shapenode with size of given platform object
            let platform = SKShapeNode(rectOf: CGSize(width: object.width, height: object.height))
            
            // Place created shapenode on given platform object position
            platform.position = CGPoint(x: object.positionx+object.width/2, y: object.positiony)
            
            // Increment name for platform object so it can be removed specifically
            platform.name = "platform\(index)"
            
            // This gives body to shapenode so player can stand on it
            platform.physicsBody = SKPhysicsBody(edgeChainFrom: platform.path!)
            
            // Other physics
            platform.physicsBody?.restitution = 0
            platform.physicsBody?.isDynamic = false
            
            // If player can not jump through platform object (so can also walk against it)
            if object.jumpThrough == false {
                
                // If object does not already exsist on scene
                if object.added == false {
                    
                    // Add platform to scene
                    self.addChild(platform)
                    
                    // Set added property to true
                    Platforms[index].added = true
                }
            }
            
            // If player is above platform object
            if playerpos > object.positiony {
                
                // If object does not already exsist on scene
                if object.added == false {
                    
                    // Add platform to scene
                    self.addChild(platform)
                    
                    // Set added property to true
                    Platforms[index].added = true
                }
                
            // If playerpos is lower than platform object
            } else {
                
                // Only remove if object is a jumpThrough object
                if object.jumpThrough == true {
                    
                    // Get specific platform shapenode
                    let child = self.childNode(withName: "platform\(index)")
                    
                    // Remove specific shapenode from scene
                    child?.removeFromParent()
                    
                    // Set added property to false
                    Platforms[index].added = false
                }
            }
        }
    }
    
    func checkForCheckpoint(){
        let checkpoint = Checkpoint().check(playerPosition: player.position)
        
        // If player stand on checkpoint
        if checkpoint != "empty" {
            //Popup().showPopupForMission(mission: checkpoint, view: view!)
            scene?.view?.isPaused = true
            
            missie = checkpoint
            
            self.popupbox.frame = CGRect(x: 0, y: Int(Responsive.getHeightScreen()), width:Int(Responsive.getWidthScreen()), height: 250)
            self.popupbox.backgroundColor = UIColor.white
            self.popupbox.layer.borderWidth = 5
            self.popupbox.isUserInteractionEnabled = true
            
            view?.addSubview(popupbox)
            
            UIView.animate(withDuration: 0.3, animations: {
                self.popupbox.frame = self.popupbox.frame.offsetBy(dx: 0.0, dy: -self.popupbox.bounds.height)
            }, completion: { finished in })
            
            // Add text to popup
            let text = UILabel(frame: CGRect(x: 50, y: 0, width: 400, height: 100))
            text.textAlignment = NSTextAlignment.center
            text.text = "Uitleg voor programmeeropdracht: \(checkpoint)"
            
            self.popupbox.addSubview(text)
            
            self.knop.frame = CGRect(x: 700, y: 100, width: 100, height: 80)
            self.knop.backgroundColor = .red
            self.knop.setTitle("Button", for: .normal)
            self.knop.isUserInteractionEnabled = true
            
            knop.addTarget(self, action: #selector(self.hidePopup), for: .touchDown)
            popupbox.addSubview(knop)
            
        }
    }
    
    func hidePopup(){
        scene?.view?.isPaused = false
        UIView.animate(withDuration: 0.3, animations: {
            self.popupbox.frame = self.popupbox.frame.offsetBy(dx: 0.0, dy: +self.popupbox.bounds.height)
        }, completion: { finished in })
    }
    
    
    override func update(_ currentTime: CFTimeInterval) {
        // Called before each frame is rendered
        enemy.enemyAttack(scene: self, position: player.position)
        enemy2.enemyAttack(scene: self, position: player.position)
        player.removeLive(view: view!)
        checkGameOver()
        calculateCamera()
        checkButtonState()
        player.checkLives(scene: scene!)
        calculatePlatforms()
        checkForCheckpoint()

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

