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
    let knop = UIButton()
    let popupbox = UIView()
    let popupboxtext = UILabel()
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
        initTraps()
        clouds.load(scene: self, amount: 30)
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
    }
    
    func initTraps(){
        Trap().load()
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
            
            self.popupbox.frame = CGRect(x: 25, y: Int(Responsive.getHeightScreen()), width:Int(Responsive.getWidthScreen()-50), height: 250)
            self.popupbox.backgroundColor = UIColor(red:254.0/255.0, green:247.0/255.0, blue:192.0/255.0, alpha: 1.0)
            self.popupbox.layer.borderColor = UIColor(red:242.0/255.0, green:155.0/255.0, blue:29.0/255.0, alpha: 1.0).cgColor
            self.popupbox.layer.borderWidth = 0
            self.popupbox.layer.shadowColor = UIColor(red:0.0/255.0, green:0.0/255.0, blue:0.0/255.0, alpha: 0.8).cgColor
            self.popupbox.layer.shadowOpacity = 1
            self.popupbox.layer.shadowOffset = CGSize.zero
            self.popupbox.layer.shadowRadius = 15
            self.popupbox.layer.shadowPath = UIBezierPath(rect: self.popupbox.bounds).cgPath
            self.popupbox.isUserInteractionEnabled = true
            self.popupbox.layer.cornerRadius = 10
            
            view?.addSubview(popupbox)
            
            let popupPosition = self.popupbox.bounds.height+25
            UIView.animate(withDuration: 0.3, animations: {
                self.popupbox.frame = self.popupbox.frame.offsetBy(dx: 0.0, dy: -popupPosition)
            }, completion: { finished in })
            
            // Add text to popup
            self.popupboxtext.frame = CGRect(x: 50, y: 0, width: self.popupbox.bounds.width-100, height: 100)
            self.popupboxtext.textAlignment = NSTextAlignment.left
            //self.popupboxtext.textColor = UIColor(red:239.0/255.0, green:196.0/255.0, blue:31.0/255.0, alpha: 1.0)
            self.popupboxtext.textColor = UIColor(red:0.0/255.0, green:0.0/255.0, blue:0.0/255.0, alpha: 1.0)
            self.popupboxtext.font = UIFont(name: "RifficFree-Bold", size: 25)
            self.popupboxtext.text = "Uitleg voor programmeeropdracht: \(checkpoint)"
            
            self.popupbox.addSubview(popupboxtext)
            
            // Add button to popup
            self.knop.frame = CGRect(x: popupbox.bounds.width-300, y: 130, width: 250, height: 90)
            self.knop.isUserInteractionEnabled = true
            let image = UIImage(named: "gaverder") as UIImage?
            self.knop.setImage(image, for: .normal)
            
            knop.addTarget(self, action: #selector(self.hidePopup), for: .touchDown)
            popupbox.addSubview(knop)
            
        }
    }
    
    func hidePopup(){
        scene?.view?.isPaused = false
        let popupPosition = self.popupbox.bounds.height+25
        UIView.animate(withDuration: 0.3, animations: {
            self.popupbox.frame = self.popupbox.frame.offsetBy(dx: 0.0, dy: +popupPosition)
        }, completion: { finished in
            self.popupbox.removeFromSuperview()
            self.popupboxtext.removeFromSuperview()
        })
    }
    
    func checkTraps(){
        for (object) in Traps {
            if player.position.x > object.positionx && object.positionx != 0.0 && player.position.x < object.positionx+object.width && player.position.y < object.positiony {
                
                let fadeOut = SKAction.fadeOut(withDuration: 0.3)
                let fadeIn = SKAction.fadeIn(withDuration: 0.3)
                let wait = SKAction.wait(forDuration: 1.0)
                let movetocheckpoint = SKAction.move(to: Global.savedPosition, duration: 0.5)
                let sequence = SKAction.sequence([fadeOut, wait, movetocheckpoint, wait, fadeIn])
                player.run(sequence)
                
            }
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
        calculatePlatforms()
        checkForCheckpoint()
        checkTraps()
        

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

