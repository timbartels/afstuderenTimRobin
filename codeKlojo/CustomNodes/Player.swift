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
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        
        let idleFrames = AnimationHelper.loadTextures(from: SKTextureAtlas(named: "idle"), withName: "player_idle")
        run(SKAction.repeatForever(SKAction.animate(with: idleFrames, timePerFrame: 0.3, resize: false, restore: false)))

    }
    
    func attack() {
        let slideFrames = AnimationHelper.loadTextures(from: SKTextureAtlas(named: "slide"), withName: "player_slide")
        let attackMoveBy: CGFloat
        
        switch viewDirection {
            case "Left":
                attackMoveBy = -20.0
            case "Right":
                attackMoveBy = 20.0
            default:
                attackMoveBy = 20
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
                                            restore: true)
        if direction < 0 {
            viewDirection = "Left"
        } else {
            viewDirection = "Right"
        }
        run(SKAction.repeatForever(moveAction), withKey:"walkingAction")
        run(SKAction.repeatForever(moveAnimation), withKey:"walkingAnimation")
    }
    
    func finishedWalking() {
        removeAction(forKey:"walkingAnimation")
        removeAction(forKey:"walkingAction")
    }
    
    func createPhysicsBody() {
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.isDynamic = true
        physicsBody?.categoryBitMask = PhysicsCategory.player
        physicsBody?.contactTestBitMask = PhysicsCategory.enemy
        physicsBody?.collisionBitMask = PhysicsCategory.platform | PhysicsCategory.enemy
        physicsBody?.allowsRotation = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
