//
//  Object.swift
//  codeKlojo
//
//  Created by Tim Bartels on 19-01-17.
//  Copyright © 2017 Tim Bartels. All rights reserved.
//

import Foundation
import SpriteKit

class Clouds: SKSpriteNode{
    func move(scene: SKScene){
        let yPosition = CGFloat(arc4random_uniform(200)+600)
        let xPosition = CGFloat(arc4random_uniform(6001))
        let scale = CGFloat(arc4random_uniform(35)+65)/100
        let randomScale = CGFloat(arc4random_uniform(2))
        
        
        let cloud = Clouds(imageNamed: "cloud")
        cloud.anchorPoint = CGPoint(x: 1,y: 1)
        let moveCloudAction = SKAction.move(to: CGPoint(x: -100, y: yPosition), duration: Double(arc4random_uniform(90)+80))
        cloud.position.x = xPosition
        cloud.position.y = yPosition
        cloud.setScale(scale)
        if randomScale == 1.0{
            cloud.xScale = -1
        }
        print(cloud.xScale)
        
        scene.addChild(cloud)
        cloud.run(SKAction.repeatForever(moveCloudAction))
        if cloud.position.x == 0{
            print("Cloud starts over")
            cloud.position.x = 6000
        }
        
    }
}
