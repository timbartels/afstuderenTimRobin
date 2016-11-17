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
    let buttons = Buttons()
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

    func animatePlayer(){
        let movementAtlas = SKTextureAtlas(named: "movement")
        var frames = [SKTexture]()
        
        let numImages = movementAtlas.textureNames.count
        for i in 1...numImages{
            let i = "movement\(i)"
            frames.append(movementAtlas.textureNamed(i))
        }

        self.run(SKAction.repeatForever(
            SKAction.animate(with: frames,
                             timePerFrame: 0.1,
                             resize: false,
                             restore: true)),
                 withKey:"walking")
        
    }
    
    func animateMove(l: Bool, r: Bool){
        if (self.action(forKey: "walking") == nil) {
            animatePlayer()
        }
        if (l){
            self.run(SKAction.moveBy(x: -10, y:0, duration: 0.1))
            self.xScale = -(charSize)
        }
        if (r){
            self.run(SKAction.moveBy(x: 10, y:0, duration: 0.1))
            self.xScale = (charSize)
        }
    }
    
    func moveEnded() {
        self.removeAction(forKey: "walking")
    }

    func jump(){
        let jumpUpAction = SKAction.moveBy(x: 0, y:200, duration:0.2)
        let jumpDownAction = SKAction.moveBy(x: 0, y:100, duration:0.5)
        let jumpSequence = SKAction.sequence([jumpUpAction, jumpDownAction])
        self.run(jumpSequence)
    }

}
