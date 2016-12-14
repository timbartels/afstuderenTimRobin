//
//  Animations.swift
//  codeKlojo
//
//  Created by Tim Bartels on 22-11-16.
//  Copyright © 2016 Tim Bartels. All rights reserved.
//

import Foundation
import SpriteKit

class Animations: Character {
    func animateWalkingPlayer(){
        let movementAtlas = SKTextureAtlas(named: "movement")
        var frames = [SKTexture]()
        
        let numImages = movementAtlas.textureNames.count
        for i in 1...numImages{
            let i = "movement\(i)"
            frames.append(movementAtlas.textureNamed(i))
        }
        
        self.run(SKAction.repeatForever(
            SKAction.animate(with: frames, timePerFrame: 0.1, resize: false, restore: true)),
                 withKey:"walking")
        
    }
    func animateJumpingPlayer(){
        let jumpAtlas = SKTextureAtlas(named: "jump")
        var frames = [SKTexture]()
        
        let numImages = jumpAtlas.textureNames.count
        for i in 1...numImages{
            let i = "jump\(i)"
            frames.append(jumpAtlas.textureNamed(i))
        }
        
        self.run(SKAction.animate(with: frames, timePerFrame: 0.1, resize: false, restore: true),
                 withKey:"jump")
        
    }
    
    func animateMove(l: Bool, r: Bool, u: Bool){
        if (l){
        //    character.moveLeft()
        }
        
        if (r){
         //   character.moveRight()
        }
        
        if(u){
         //   character.jump()
        }
        
        if (self.action(forKey: "walking") == nil && self.action(forKey: "jump") == nil) {
            animateWalkingPlayer()
        }
    }

}
