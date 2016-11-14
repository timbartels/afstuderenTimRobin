//
//  Character.swift
//  codeKlojo
//
//  Created by Tim Bartels on 10-11-16.
//  Copyright © 2016 Tim Bartels. All rights reserved.
//

import Foundation
import SpriteKit

class Character: SKSpriteNode {
    var characterWalkingFrames : [SKTexture]!
    var charSize = CGFloat(0.18)
    func load() {
        self.setScale(charSize)
        self.anchorPoint = CGPoint(x: 0.5,y: 0)
        self.position = CGPoint(x: -100, y: 100)
        self.physicsBody = SKPhysicsBody()
        if let physics = self.physicsBody {
            physics.affectedByGravity = true
            physics.allowsRotation = true
            physics.isDynamic = true;
            physics.linearDamping = 5.75
            physics.angularDamping = 100.75
        }
    }
    
    func moveRight(){
        self.position.x += 50.0
        self.xScale = (charSize)
    }
    func moveLeft(){
        self.position.x -= 50.0
        self.xScale = -(charSize)
    }

}
