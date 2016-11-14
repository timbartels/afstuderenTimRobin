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
        self.lineWidth = 5
        self.physicsBody = SKPhysicsBody(edgeChainFrom: self.path!)
        self.physicsBody?.restitution = 0.75
        self.physicsBody?.isDynamic = false
        
    }
}
