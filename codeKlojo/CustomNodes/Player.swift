//
//  Player.swift
//  codeKlojo
//
//  Created by Tim Bartels on 23-11-16.
//  Copyright © 2016 Tim Bartels. All rights reserved.
//

import Foundation
import SpriteKit

class Player: SKSpriteNode {
    var viewDirection = "Right"
    var attackState = false
    
    init() {
        let texture = SKTexture(imageNamed: "player_idle" + "1")
        super.init(texture: texture, color: UIColor.clear, size: CGSize.zero)
        let idleFrames = AnimationHelper.loadTextures(from: SKTextureAtlas(named: "idle"), withName: "player_idle")
        run(SKAction.repeatForever(SKAction.animate(with: idleFrames, timePerFrame: 0.3, resize: true, restore: false)))

    }
    
    func attack() {
        let slideFrames = AnimationHelper.loadTextures(from: SKTextureAtlas(named: "slide"), withName: "player_slide")
        var attackMoveBy = CGFloat(20)
         
        if viewDirection == "Left" {
            attackMoveBy = CGFloat(-20)
        }
          
        let attackAction = SKAction.moveBy(x: attackMoveBy, y:0, duration:0.4)
        let beginState = SKAction.run {
            self.attackState = true
        }
        let endState = SKAction.run {
            self.attackState = false
        }
        let wait = SKAction.wait(forDuration: 0.1)
        let attackSequence = SKAction.sequence([beginState, attackAction, wait, endState])
        run(attackSequence)
        run(SKAction.animate(with: slideFrames, timePerFrame: 0.1, resize: true, restore: true))
    }
    
    func jump() {
        let jumpUpAction = SKAction.moveBy(x: 0, y: 50, duration:0.2)
        let jumpFrames = AnimationHelper.loadTextures(from: SKTextureAtlas(named: "jump"), withName: "player_jump")
        
        run(jumpUpAction)
        run(SKAction.animate(with: jumpFrames, timePerFrame: 0.1, resize: true, restore: false))
    }
    
    func walkTo(direction: CGFloat) {
        let walkFrames = AnimationHelper.loadTextures(from: SKTextureAtlas(named: "walk"), withName: "player_walk")
        let moveAction = SKAction.moveBy(x: direction, y:0, duration: 0.1)
        let moveAnimation = SKAction.animate(with: walkFrames,
                                            timePerFrame: 0.1,
                                            resize: true,
                                            restore: false)
        if direction < 0 {
            xScale = -(xScale)
        } else {
            xScale = (xScale)
        }
        
        run(SKAction.repeatForever(SKAction.sequence([moveAction, moveAnimation])),
                   withKey:"walking")
    }
    
    func createPhysicsBody() {
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.isDynamic = true
        physicsBody?.categoryBitMask = PhysicsCategory.enemy
        physicsBody?.contactTestBitMask = PhysicsCategory.all
        physicsBody?.collisionBitMask = PhysicsCategory.all
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
