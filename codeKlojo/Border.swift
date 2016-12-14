//
//  Border.swift
//  codeKlojo
//
//  Created by Tim Bartels on 14-12-16.
//  Copyright © 2016 Tim Bartels. All rights reserved.
//

import Foundation
import SpriteKit

class Border: SKShapeNode{
    func load(position: CGPoint) {
        self.physicsBody = SKPhysicsBody(edgeChainFrom: self.path!)
        self.physicsBody?.restitution = 0
        self.physicsBody?.isDynamic = false
        self.position = position
        self.alpha = 0
    }

    func showLives(){
        let lives = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        lives.center = CGPoint(x: 160, y: 285)
        lives.textAlignment = .center
        lives.text = String(Player().gameover)
    }
    
}
