//
//  Enemy.swift
//  codeKlojo
//
//  Created by Tim Bartels on 13-12-16.
//  Copyright © 2016 Tim Bartels. All rights reserved.
//

import SpriteKit
import Darwin

class Enemy: Character {
    let minRange = 75
    let maxRange = 400
    let enemySize = CGFloat(0.3)
    override func load() {
        super.load()
        self.position = CGPoint(x: 500,y: 150)
        self.setScale(enemySize)

    }
    func walking() {

    }
    func moveTo(pos: CGPoint){
        let diff = Int(pos.x) - Int(self.position.x)
        if -(maxRange) ... -(minRange) ~= diff{
            self.run(SKAction.moveBy(x: -5, y:0, duration: 0.2))
            self.xScale = (enemySize)
        }else if minRange ... maxRange ~= diff{
            self.run(SKAction.moveBy(x: 5, y:0, duration: 0.2))
            self.xScale = -(enemySize)
        }
    }
    
    func fireBullet(scene: SKScene){
        let bullet = Bullet(imageNamed: "bullet")
        bullet.anchorPoint = CGPoint(x: 0.5,y: 0.5)
        bullet.position.x = self.position.x
        bullet.position.y = self.position.y
        scene.addChild(bullet)
        let moveBulletAction = SKAction.move(to: CGPoint(x:self.position.x-1000, y: self.position.y), duration: 2.0)
        let removeBulletAction = SKAction.removeFromParent()
        bullet.run(SKAction.sequence([moveBulletAction,removeBulletAction]))
    }


}
