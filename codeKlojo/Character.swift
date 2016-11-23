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
    var charSize = CGFloat(0.18)
    func load() {
        self.setScale(charSize)
        self.anchorPoint = CGPoint(x: 0.5,y: 0)
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width, height: self.size.height))
        if let physics = self.physicsBody {
            physics.affectedByGravity = true
            physics.isDynamic = true
            physics.restitution = 0
            physics.allowsRotation = false
        }
    }
    
    func animatePlayer(jump: Bool, move: Bool){
        let movementAtlas = SKTextureAtlas(named: "movement")
        switch (jump, move) {
        case (true, false):
            var framesJump = [SKTexture]()
            let frames = [11,12,11]
            for jump in frames{
                let jump = "movement\(jump)"
                framesJump.append(movementAtlas.textureNamed(jump))
                
            }
            self.run(
                SKAction.animate(with: framesJump,
                                 timePerFrame: 0.1,
                                 resize: false,
                                 restore: true), withKey:"jump")
        case (false, true):
            var framesMove = [SKTexture]()
            let frames = [3,4,5,6,7,6,5,4,3,8,9,10,9,8]
            for move in frames{
                let move = "movement\(move)"
                framesMove.append(movementAtlas.textureNamed(move))
            }
            
            self.run(SKAction.repeatForever(
                SKAction.animate(with: framesMove,
                                 timePerFrame: 0.05,
                                 resize: false,
                                 restore: true)),
                     withKey:"walking")
        
        case (false, true):
            var framesMove = [SKTexture]()
            let frames = [3,4,5,6,7,6,5,4,3,8,9,10,9,8]
            for move in frames{
                let move = "movement\(move)"
                framesMove.append(movementAtlas.textureNamed(move))
            }
            
            self.run(SKAction.repeatForever(
                SKAction.animate(with: framesMove,
                                 timePerFrame: 0.05,
                                 resize: false,
                                 restore: true)),
                     withKey:"walking")

        default:
            var framesIdle = [SKTexture]()
            let frames = [3,1]
            for idle in frames{
                let idle = "movement\(idle)"
                framesIdle.append(movementAtlas.textureNamed(idle))
            }
            
            self.run(SKAction.repeatForever(
                SKAction.animate(with: framesIdle,
                                 timePerFrame: 0.4,
                                 resize: false,
                                 restore: true)),
                     withKey:"idle")
        }
        
    }
    
    func moveLeft(){
        self.run(SKAction.moveBy(x: -10, y:0, duration: 0.1))
        self.xScale = -(charSize)
    }
    
    func moveRight(){
        self.run(SKAction.moveBy(x: 10, y:0, duration: 0.1))
        self.xScale = (charSize)
    }
    
    func moveEnded() {
        self.removeAction(forKey: "walking")
    }

    func jump(){
        let jumpUpAction = SKAction.moveBy(x: 0, y:200, duration:0.2)
        // let jumpDownAction = SKAction.moveBy(x: 0, y:100, duration:0.5)
        let jumpSequence = SKAction.sequence([jumpUpAction])
        self.run(jumpSequence)
        animatePlayer(jump: true, move: false)
    }

}
