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

    override func load() {
        //Sets the frames of the different animations in an Array, 
        // so they won't load every time when used.
        
        framesMove = loadAnimation(animation: 1)
        framesJump = loadAnimation(animation: 2)
        framesIdle = loadAnimation(animation: 3)
        self.setScale(charSize)
        self.anchorPoint = CGPoint(x: 0.5,y: 0)
        self.position = Global.savedPosition
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width, height: self.size.height))
        if let physics = self.physicsBody {
            physics.affectedByGravity = true
            physics.isDynamic = true
            physics.restitution = 0
            physics.allowsRotation = false
        }
        self.run(SKAction.repeatForever(
            SKAction.animate(with: framesIdle,
                             timePerFrame: 0.4,
                             resize: false,
                             restore: true)),
                 withKey:"idle")

    }
    
    func animateMove(l: Bool, r: Bool){
        if (l){
            moveLeft()
        }
        
        if (r){
            moveRight()
        }
        
        if (self.action(forKey: "walking") == nil && self.action(forKey: "jump") == nil) {
            animatePlayer(jump: false, move: true)
        }
    }
    func checkLives(){
        let positionPlayer = self.position
        let endLine = CGPoint(x: self.position.x, y: 0)
        if (positionPlayer.y <= endLine.y){
            self.load()
            self.lives -= 1
            
            
        }
    }
}
