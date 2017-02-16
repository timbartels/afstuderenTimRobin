//
//  Background.swift
//  codeKlojo
//
//  Created by Tim Bartels on 10-11-16.
//  Copyright © 2016 Tim Bartels. All rights reserved.
//

import Foundation
import SpriteKit

class Background {
    var backgroundPosition = 0
    var bg = SKSpriteNode()
    var array = [SKSpriteNode]()
    func load(scene: SKScene) -> Array<SKSpriteNode> {
        for i in 1...5 {
            bg = SKSpriteNode(imageNamed: "level\(i)")
            bg.anchorPoint = CGPoint(x: 0,y: 0)
            bg.position = CGPoint(x: backgroundPosition, y: 0)
            backgroundPosition += 2000 // width of every part
            bg.size.height = Responsive.getHeightScreen()
            bg.size.width = 2000
            bg.zPosition = -99
            scene.addChild(bg)
            array.append(bg)
        }
    
       return array
    }
}
