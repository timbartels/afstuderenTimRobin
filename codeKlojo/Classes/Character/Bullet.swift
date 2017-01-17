//
//  Bullet.swift
//  codeKlojo
//
//  Created by Tim Bartels on 17-01-17.
//  Copyright © 2017 Tim Bartels. All rights reserved.
//

import Foundation
import SpriteKit

class Bullet: SKSpriteNode {
    var shooting = false
       
    func load() {
        self.setScale(2)
        self.anchorPoint = CGPoint(x: 0.5,y: 0.5)
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width, height: self.size.height))
        if let physics = self.physicsBody {
            physics.affectedByGravity = false
            physics.isDynamic = true
            physics.restitution = 0
            physics.allowsRotation = false
        }
    }
    
}
