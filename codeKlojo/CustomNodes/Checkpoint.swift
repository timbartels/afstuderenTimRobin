//
//  Checkpoint.swift
//  codeKlojo
//
//  Created by Robin Woudstra on 07-12-16.
//  Copyright © 2016 Tim Bartels. All rights reserved.
//

import Foundation
import SpriteKit


struct Mission {
    let title: String
    let explanation: String
    let setup: String
    let answer: String
}

class Checkpoint: SKSpriteNode{
    init() {
        let texture = SKTexture(imageNamed: "mission")
        super.init(texture: texture, color: UIColor.clear, size: CGSize.zero)
        animate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animate() {
        var scale = SKAction.scale(to: 1.0, duration: 1.0)
    
        if xScale > 0.5 {
             scale = SKAction.scale(to: 0.5, duration: 1.0)
        }
        let completion = SKAction.run(){
            self.animate()
        }
        let sequence = SKAction.sequence([scale, completion])
        run(sequence)
    }
    
    func check(scene: CityScreenScene, position: CGPoint) -> Bool {
        if(position.x > self.position.x && self.position.y-50 < position.y && position.y < self.position.y+50){
            Position.saved = CGPoint(x: self.position.x, y: self.position.y)
            return true
        }
        return false
    }
}

