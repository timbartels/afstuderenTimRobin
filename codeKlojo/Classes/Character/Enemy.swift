//
//  Enemy.swift
//  codeKlojo
//
//  Created by Tim Bartels on 13-12-16.
//  Copyright © 2016 Tim Bartels. All rights reserved.
//

import SpriteKit

class Enemy: Character {
    override func load() {
        //Sets the frames of the different animations in an Array,
        // so they won't load every time when used.
        
        framesMove = loadAnimation(animation: 1)
        framesJump = loadAnimation(animation: 2)
        framesIdle = loadAnimation(animation: 3)
        self.setScale(charSize)
        self.anchorPoint = CGPoint(x: 0.5,y: 0)
        self.position = CGPoint(x: 1000,y: 100)
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

}
