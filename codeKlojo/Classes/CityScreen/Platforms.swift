//
//  Platforms.swift
//  codeKlojo
//
//  Created by Robin Woudstra on 16-02-17.
//  Copyright © 2017 Tim Bartels. All rights reserved.
//

import Foundation
import SpriteKit


var Platforms = [Platform()]

class Platform {
    var positionx = CGFloat()
    var positiony = CGFloat()
    var width     = CGFloat()
    var height    = CGFloat()
    var jumpable  = Bool()
    
    func load(){
        let platform1 = Platform()
        platform1.positionx =   3840
        platform1.positiony =   180
        platform1.width     =   50
        platform1.height    =   70
        platform1.jumpable      =   false
        
        Platforms.append(platform1)
        
        let platform2 = Platform()
        platform2.positionx =   3885
        platform2.positiony =   300
        platform2.width     =   500
        platform2.height    =   50
        platform2.jumpable      =   false
        
        Platforms.append(platform2)
        
    }
    
    func placePlatforms(scene: SKScene){
        for object in Platforms {
            
            let platform = SKShapeNode(rectOf: CGSize(width: object.width, height: object.height))
            platform.fillColor = SKColor.red
            platform.position = CGPoint(x: object.positionx+object.width/2, y: object.positiony)
            platform.physicsBody = SKPhysicsBody(edgeChainFrom: platform.path!)
            platform.physicsBody?.restitution = 0
            platform.physicsBody?.isDynamic = false
            
            scene.addChild(platform)
        }
    }
    
    
}
