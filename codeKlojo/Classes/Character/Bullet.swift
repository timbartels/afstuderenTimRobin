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
    func shoot(obj: SKSpriteNode){
        self.position = obj.position
        self.move(toParent: Player())
    }
    
}
