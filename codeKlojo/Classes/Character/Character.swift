
//  Character.swift
//  codeKlojo
//
//  Created by Tim Bartels on 10-11-16.
//  Copyright © 2016 Tim Bartels. All rights reserved.
//

import Foundation
import SpriteKit

class Character: SKSpriteNode {
    var charSize = CGFloat(0.15)
    var framesMove = [SKTexture]()
    var framesJump = [SKTexture]()
    var framesIdle = [SKTexture]()
    
    func load(scene: SKScene) {
        // Sets the frames of the different animations in an Array,
        // So they won't load every time when used.
        framesMove = loadAnimation(animation: 1)
        framesJump = loadAnimation(animation: 2)
        framesIdle = loadAnimation(animation: 3)
        self.setScale(charSize)
        self.anchorPoint = CGPoint(x: 0.5,y: 0.5)
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width, height: self.size.height))
        if let physics = self.physicsBody {
            physics.affectedByGravity = true
            physics.isDynamic = true
            physics.restitution = 0
            physics.allowsRotation = false
        }
    }
    
    func loadAnimation(animation: Int)->[SKTexture]{
        let movementAtlas = SKTextureAtlas(named: "movement")
        // Checks which frames will set
        // Double Check this function :S
        switch (animation) {
        case(1):
            let frames = [3,4,5,6,7,6,5,4,3,8,9,10,9,8]
            for move in frames{
                let move = "movement\(move)"
                framesMove.append(movementAtlas.textureNamed(move))
            }
            return framesMove
        case(2):
            let jumpframes = [11,12,11]
            for jump in jumpframes{
                let jump = "movement\(jump)"
                framesJump.append(movementAtlas.textureNamed(jump))
            }
            return framesJump
        default:
            let idleframes = [3,1,3,1,3,1,2]
            for idle in idleframes{
                let idle = "movement\(idle)"
                framesIdle.append(movementAtlas.textureNamed(idle))
            }
            return framesIdle
        }
    }
    
    func animatePlayer(jump: Bool, move: Bool){
        //Sets the animation when move is pressed
        switch (jump, move) {
        case (true, false):
            self.run(
                SKAction.animate(with: framesJump,
                                 timePerFrame: 0.1,
                                 resize: false,
                                 restore: true), withKey:"jump")
        case (false, true):
            self.run(SKAction.repeatForever(
                SKAction.animate(with: framesMove,
                                 timePerFrame: 0.05,
                                 resize: false,
                                 restore: true)),
                     withKey:"walking")
        
        default:
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
        // Allowed position to jump, so player cannot jump in air
        let allowedPositionToJump = Global.floorPosition.y+self.size.height/2+5
        
        if(self.position.y < allowedPositionToJump){
            let jumpUpAction = SKAction.moveBy(x: 0, y:200, duration:0.2)
            let jumpSound = SKAction.playSoundFileNamed("jump.wav", waitForCompletion:false)
            // let jumpDownAction = SKAction.moveBy(x: 0, y:100, duration:0.5)
            let jumpSequence = SKAction.sequence([jumpUpAction, jumpSound])
            self.run(jumpSequence)
            animatePlayer(jump: true, move: false)
        }
    }

}
