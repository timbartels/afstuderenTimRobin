//
//  Platforms.swift
//  codeKlojo
//
//  Created by Robin Woudstra on 16-02-17.
//  Copyright © 2017 Tim Bartels. All rights reserved.
//

import SpriteKit

class Platform: SKSpriteNode {   
    init() {
        super.init(texture: nil, color: UIColor.clear, size: CGSize.zero)
    }
          
    required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
          
    func createPhysicsBody(){
      physicsBody = SKPhysicsBody(rectangleOf: size)
      physicsBody?.isDynamic = false
      physicsBody?.categoryBitMask = PhysicsCategory.platform
      physicsBody?.collisionBitMask = PhysicsCategory.player | PhysicsCategory.enemy
    }
}
