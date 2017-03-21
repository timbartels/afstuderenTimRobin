
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
    var framesSlide = [SKTexture]()
    var framesIdle = [SKTexture]()
    var mayJump = true
    
    func load(scene: SKScene) {
        // Sets the frames of the different animations in an Array,
        // So they won't load every time when used.
        framesMove = loadAnimation(animation: 1)
        framesJump = loadAnimation(animation: 2)
        framesSlide = loadAnimation(animation: 3)
        framesIdle = loadAnimation(animation: 4)
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
            let frames = [7,8,9,10,11,12]
            for move in frames{
                let move = "movement\(move)"
                framesMove.append(movementAtlas.textureNamed(move))
            }
            return framesMove
        case(2):
            let jumpframes = [13,14,15,16]
            for jump in jumpframes{
                let jump = "movement\(jump)"
                framesJump.append(movementAtlas.textureNamed(jump))
            }
            return framesJump
        case(3):
            let slideframes = [17,18,19,20]
            for slide in slideframes{
                let slide = "movement\(slide)"
                framesSlide.append(movementAtlas.textureNamed(slide))
            }
            return framesSlide
        default:
            let idleframes = [1,2,3,4,5,6,5,4,3,2,1]
            for idle in idleframes{
                let idle = "movement\(idle)"
                framesIdle.append(movementAtlas.textureNamed(idle))
            }
            return framesIdle
        }
    }
    
    func animatePlayer(jump: Bool, move: Bool, slide: Bool){
        //Sets the animation when move is pressed
        switch (jump, move, slide) {
        case (true, false, false):
            self.run(
                SKAction.animate(with: framesJump,
                                 timePerFrame: 0.1,
                                 resize: false,
                                 restore: true), withKey:"jump")
        case (false, true, false):
            self.run(SKAction.repeatForever(
                SKAction.animate(with: framesMove,
                                 timePerFrame: 0.05,
                                 resize: false,
                                 restore: true)),
                     withKey:"walking")
        case (false, false, true):
            self.run(
                SKAction.animate(with: framesSlide,
                                 timePerFrame: 0.10,
                                 resize: false,
                                 restore: true),
                     withKey:"slide")
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
        self.run(SKAction.moveBy(x: -6, y:0, duration: 0.1))
        self.xScale = -(charSize)
    }
    
    func moveRight(){
        self.run(SKAction.moveBy(x: 6, y:0, duration: 0.1))
        self.xScale = (charSize)
    }
    
    func moveEnded() {
        self.removeAction(forKey: "walking")
    }

    func jump(){
        
        if(mayJump == true){
            let jumpUpAction = SKAction.moveBy(x: 0, y:190, duration:0.2)
            let jumpSound = SKAction.playSoundFileNamed("jump.wav", waitForCompletion:false)
            let jumpStarted = SKAction.run(){
                self.mayJump = false
            }
            
            let jumpCompleted = SKAction.run(){
                self.mayJump = true                
            }
            let jumpSequence = SKAction.sequence([jumpStarted, jumpUpAction, jumpSound, jumpCompleted])
            self.run(jumpSequence)
            animatePlayer(jump: true, move: false, slide: false)
        }
    }

}
