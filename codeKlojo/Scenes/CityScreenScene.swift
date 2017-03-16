//
//  GameScene.swift
//  codeKlojo
//
//  Created by Tim Bartels on 08-11-16.
//  Copyright © 2016 Tim Bartels. All rights reserved.
//

import SpriteKit
import GameplayKit
import WebKit

class CityScreenScene: SKScene, SKPhysicsContactDelegate, SceneManager {
    var mute = false
    let textField = UITextView(frame: CGRect(x: screenSize.width/2, y: 0, width: screenSize.width/2, height: screenSize.height/2-10 ))
    let webView = WKWebView()
    let syntaxLabel = UILabel()
    let returnLabel = UILabel()
    let submit = UIButton()
    let widthLevel = 15000
    let mission = Mission()
    let cam = SKCameraNode()
    var backgroundMusic = SoundEngine()
    let background = Background()
    let player = Player(texture: SKTextureAtlas(named: "movement").textureNamed("movement1"))
    let bullet = Bullet(imageNamed: "bullet")
    var wall = Border(rectOf: CGSize(width: 10, height: Responsive.getHeightScreen()))
    var level = CityLevel()
    let clouds = Clouds()
    let enemy = Enemy(imageNamed: "robot.png")
    let enemy1 = Enemy(imageNamed: "robot.png")
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
    func submit(view: UIView){
        submit.backgroundColor = UIColor.blue
        submit.frame = CGRect(x: screenSize.width-50, y: 0, width: 50, height: 50)
        submit.layer.zPosition = 10
        submit.addTarget(self, action:#selector(checkJavascript(sender:)), for: .touchUpInside)
        submit.setTitle("▶️", for: .normal)
        view.addSubview(submit)
    }

    func initBackground(){
        // Init background
        self.backgroundColor = SKColor(red: CGFloat(188.0/255.0), green: CGFloat(228.0/255.0), blue: CGFloat(227.0/255.0), alpha: 0)
        background.load(scene: self)
    }
    func initEnemies(){
        enemy.load(scene: self, position: CGPoint(x: 500, y:150))
        enemy1.load(scene: self, position: CGPoint(x: 1000, y:150))
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
    
    func checkJavascript(sender: UIButton){
        self.webView.evaluateJavaScript(self.textField.text!){ (result, error) in
            var errorCode: Int
            var errorMessage: String
            //var errorSyntax: String
            //var errorLine: Int
            if error == nil {
                self.mission.syntaxError = "✔︎"
                self.returnLabel.text = "\(result!)"
                self.checkResult(answer: self.returnLabel.text!)
            }else{
                print(error!)
                //let errorTest = (error! as NSError).userInfo
                //errorLine = errorTest[AnyHashable("WKJavaScriptExceptionLineNumber")] as! Int
                // errorSyntax = errorTest[AnyHashable("WKJavaScriptExceptionMessage")] as! String
                errorMessage = (error?.localizedDescription)!
                errorCode = (error?._code)!
                self.mission.syntaxError = "\(errorMessage) on line \(errorCode)"
            }
        }
        self.syntaxLabel.text = self.mission.syntaxError
    }

    func checkResult(answer: String){
        if answer == "4"{
            scene?.view?.isPaused = false
            textField.removeFromSuperview()
            returnLabel.removeFromSuperview()
            syntaxLabel.removeFromSuperview()
            submit.removeFromSuperview()
            initController()
            controllerButtons.buttonStateL = false
            controllerButtons.buttonStateR = false
            player.initLives(view: view!)
            
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
          
        if (contact.bodyA.categoryBitMask == PhysicsCategory.player &&
            contact.bodyB.categoryBitMask == PhysicsCategory.enemy) {
            if player.attackState == true{
                contact.bodyB.node?.removeFromParent()
            }else{
               player.lives -= 1
            }
            
        }
        if (contact.bodyA.categoryBitMask == PhysicsCategory.player &&
            contact.bodyB.categoryBitMask == PhysicsCategory.bullet) {
            contact.bodyB.node?.removeFromParent()
            player.lives -= 1
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
            for view in (self.view?.subviews)! {
                view.removeFromSuperview()
            }
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
        let opdracht = "1+1;"
        // scene?.view?.isPaused = false
        let popupPosition = self.popupbox.bounds.height+25
        UIView.animate(withDuration: 0.3, animations: {
            self.popupbox.frame = self.popupbox.frame.offsetBy(dx: 0.0, dy: +self.popupbox.bounds.height)
        }, completion: { finished in
            self.popupbox.removeFromSuperview()
            self.popupboxtext.removeFromSuperview()
            self.textField.backgroundColor = UIColor.black
            self.textField.becomeFirstResponder()
            self.textField.textColor = UIColor.white
            self.textField.autocorrectionType = .no
            self.textField.autocapitalizationType = .none
            self.textField.spellCheckingType = .no
            self.textField.font = UIFont(name: "Courier", size: 15)
            self.textField.showsVerticalScrollIndicator = true
            self.textField.layer.zPosition = 2
            
            self.syntaxLabel.font = UIFont(name: "Courier", size: 10)
            self.syntaxLabel.textColor = UIColor.black
            self.syntaxLabel.backgroundColor = UIColor.green
            self.syntaxLabel.textAlignment = .center
            self.syntaxLabel.layer.zPosition = 5
            self.syntaxLabel.frame = CGRect(x: screenSize.width/2, y: screenSize.height/2-60, width: screenSize.width/2, height: 50)
            
            self.returnLabel.font = UIFont(name: "Courier", size: 40)
            self.returnLabel.textColor = UIColor.black
            self.returnLabel.backgroundColor = UIColor.red
            self.returnLabel.textColor = UIColor.white
            self.returnLabel.textAlignment = .center
            self.returnLabel.layer.zPosition = 5
            self.returnLabel.frame = CGRect(x: screenSize.width/6, y: screenSize.height/4-50, width: screenSize.width/4, height: 100)
            
            self.textField.text = opdracht
            self.view?.addSubview(self.syntaxLabel)
            self.view?.addSubview(self.returnLabel)
            self.view?.addSubview(self.textField)
            self.textField.becomeFirstResponder()
            self.submit(view: self.view!)
        })
    }
    
    
    override func update(_ currentTime: CFTimeInterval) {
        // Called before each frame is rendered
        enemy.enemyAttack(scene: self, position: player.position)
        enemy1.enemyAttack(scene: self, position: player.position)
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

