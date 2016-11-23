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
    override func load() {
        self.setScale(charSize)
        self.anchorPoint = CGPoint(x: 0.5,y: 0)
        self.position = CGPoint(x: 0, y: 100)
        
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width, height: self.size.height))
        if let physics = self.physicsBody {
            physics.affectedByGravity = true
            physics.isDynamic = true
            physics.restitution = 0
            physics.allowsRotation = false
        }
        
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
    func checkGameOver(){
        let gameover = CGPoint(x: self.position.x, y: 0)
        let positionPlayer = self.position
        if (positionPlayer.y <= gameover.y){
            self.load()
        }
    }
}
    
