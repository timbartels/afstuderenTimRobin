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
        self.setScale(0.5)
        self.anchorPoint = CGPoint(x: 0.5,y: 0.5)
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width, height: self.size.height/2))
        self.physicsBody?.categoryBitMask = PhysicsCategory.bullet
        self.physicsBody?.contactTestBitMask = PhysicsCategory.player

        if let physics = self.physicsBody {
            physics.affectedByGravity = false
            physics.isDynamic = true
            physics.restitution = 0
            physics.allowsRotation = false
            
        }
    }
        
}

//class Bullet: SKSpriteNode {
//    var shooting = false
//       
//    init() {
//        let texture = SKTexture(imageNamed: "bullet")
//        super.init(texture: texture, color: UIColor.red, size: CGSize.zero)
//    }
//    
//    func createPhysicsBody() {
//        setScale(0.5)
//        anchorPoint = CGPoint(x: 0.5,y: 0.5)
//        physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width, height: self.size.height/2))
//        physicsBody?.categoryBitMask = PhysicsCategory.bullet
//        physicsBody?.contactTestBitMask = PhysicsCategory.player
//        physicsBody?.affectedByGravity = false
//        physicsBody?.isDynamic = true
//        physicsBody?.restitution = 0
//        physicsBody?.allowsRotation = false
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//}
