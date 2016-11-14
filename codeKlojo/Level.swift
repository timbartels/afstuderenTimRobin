//
//  Level.swift
//  codeKlojo
//
//  Created by Robin Woudstra on 14-11-16.
//  Copyright © 2016 Tim Bartels. All rights reserved.
//

import Foundation
import SpriteKit

class Level:SKShapeNode{
    func loadFloor() {
                
        self.fillColor = SKColor.white
        let responsive = Responsive()
        let height = responsive.getHeightScreen()
        self.position = CGPoint(x: -100, y: 30)
        self.physicsBody = SKPhysicsBody()
        if let physics = self.physicsBody {
            let groundCategory:UInt32 = 1 << 1
            physics.categoryBitMask = groundCategory
            
            physics.affectedByGravity = false
            physics.allowsRotation = true
            physics.isDynamic = false;
            physics.linearDamping = 5.75
            physics.angularDamping = 100.75
        }
        
    }
}
