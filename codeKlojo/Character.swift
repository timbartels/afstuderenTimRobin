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
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width, height: self.size.height))
        if let physics = self.physicsBody {
            physics.affectedByGravity = true
            physics.isDynamic = true
            physics.restitution = 0
            physics.allowsRotation = false
        }
    }
    
    func animateMove(){
        var frames: [SKTexture] = []
        for i in 1...8{
            let i = SKTexture.init(imageNamed: "movement\(i)")
            frames.append(i)
        }
        print(frames)
        let animation = SKAction.animate(with: frames, timePerFrame: 0.05)
        self.run(SKAction.repeatForever(animation))
    }
    
    func moveRight(){
        self.animateMove()
        let moveRightAction = SKAction.moveBy(x: 10, y:0, duration: 0.1)
        self.run(moveRightAction)
        self.xScale = (charSize)
    }
    func moveLeft(){
        self.animateMove()
        let moveLeftAction = SKAction.moveBy(x: -10, y:0, duration: 0.1)
        self.run(moveLeftAction)
        self.xScale = -(charSize)
    }
    func jump(){
        let jumpUpAction = SKAction.moveBy(x: 0, y:200, duration:0.2)
        let jumpDownAction = SKAction.moveBy(x: 0, y:100, duration:0.5)
        let jumpSequence = SKAction.sequence([jumpUpAction, jumpDownAction])
        self.run(jumpSequence)
    }

}
