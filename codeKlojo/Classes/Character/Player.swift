//
//  Player.swift
//  codeKlojo
//
//  Created by Tim Bartels on 23-11-16.
//  Copyright © 2016 Tim Bartels. All rights reserved.
//

import Foundation
import SpriteKit

class Player: Character {
    var gameover = 0
    var lives = 3
    var label = UILabel()
    var liveImage = UIImageView()
    var viewDirection = "Right"

    override func load(scene: SKScene) {
        super.load(scene: scene)
        self.position = Global.savedPosition
        // idle stance
        self.animatePlayer(jump: false, move: false, slide: false)
        // self.texture = framesIdle.first
        self.physicsBody?.contactTestBitMask = PhysicsCategory.bullet
        self.physicsBody?.contactTestBitMask = PhysicsCategory.enemy
        self.physicsBody?.categoryBitMask = PhysicsCategory.player
        
        // Override to reduce physicsbox size
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width/2, height: self.size.height))
        if let physics = self.physicsBody {
            physics.affectedByGravity = true
            physics.isDynamic = true
            physics.restitution = 0
            physics.allowsRotation = false
        }
        
        if self.parent == nil {
            scene.addChild(self)
        }
        
    }
    
    func animateMove(l: Bool, r: Bool){
        if (l){
            moveLeft()
            viewDirection = "Left"
        }
        
        if (r){
            moveRight()
            viewDirection = "Right"
        }
        
        if (self.action(forKey: "walking") == nil && self.action(forKey: "jump") == nil) {
            animatePlayer(jump: false, move: true, slide: false)
        }
    }
    func checkLives(scene: SKScene){
        let positionPlayer = self.position
        let endLine = CGPoint(x: self.position.x, y: 0)
        if (positionPlayer.y <= endLine.y){
            self.load(scene: scene)
            self.lives -= 1
        }
    }
    
    func initLives(view: UIView){
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
    
    func removeLive(view: UIView){
        // Remove life image
        if (self.lives > 0){
            for _ in 1...3 {
                view.viewWithTag(self.lives+1)?.alpha = 0.7
            }
        }
    }
    
    func attack(){
        //self.zRotation = CGFloat(1.4)
        var attackMoveBy = CGFloat(200)
//        var rotationAngle = CGFloat(1.50)
       
        if self.viewDirection == "Left" {
            attackMoveBy = CGFloat(-200)
//            rotationAngle = CGFloat(-1.50)
        }
        
        let attackAction = SKAction.moveBy(x: attackMoveBy, y:0, duration:0.2)
        // let attackRotation = SKAction.rotate(byAngle: rotationAngle, duration: 0.1)
        let attackSound = SKAction.playSoundFileNamed("jump.wav", waitForCompletion:false)
        // let attackRotationDone = SKAction.rotate(byAngle: -rotationAngle, duration: 0.1)
        // let jumpDownAction = SKAction.moveBy(x: 0, y:100, duration:0.5)
        let attackSequence = SKAction.sequence([attackAction, attackSound])
        self.run(attackSequence)
        animatePlayer(jump: false, move: false, slide: true)
    }


}
