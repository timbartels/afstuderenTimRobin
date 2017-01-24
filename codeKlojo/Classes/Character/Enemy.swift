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
    let bulletRange = CGFloat(500)
    var enemyDirection = "left"
    var inRange = false
    var mayFire = true
    
    override func load(scene: SKScene) {
        super.load(scene: scene)
        self.position = CGPoint(x: 500,y: 150)
        self.setScale(enemySize)
        self.physicsBody?.categoryBitMask = PhysicsCategory.enemy
        self.physicsBody?.contactTestBitMask = PhysicsCategory.player
        scene.addChild(self)

    }
    func walking() {

    }
    func moveTo(pos: CGPoint){
        inRange = false
        let diff = Int(pos.x) - Int(self.position.x)
        if -(maxRange) ... -(minRange) ~= diff{
            self.run(SKAction.moveBy(x: -5, y:0, duration: 0.2))
            self.xScale = (enemySize)
            inRange = true
            enemyDirection = "left"
        }else if minRange ... maxRange ~= diff{
            self.run(SKAction.moveBy(x: 5, y:0, duration: 0.2))
            self.xScale = -(enemySize)
            inRange = true
            enemyDirection = "right"
        }
    }
    
    func fireBullet(scene: SKScene){
        let bullet = Bullet(imageNamed: "bullet")
        bullet.load()
        bullet.anchorPoint = CGPoint(x: 0.5,y: 0.5)
        bullet.position.x = self.position.x-100
        bullet.position.y = self.position.y
        bullet.setScale(0.5)
        
        var direction = self.position.x-bulletRange
        if enemyDirection == "right" {
            bullet.xScale = -(CGFloat(0.5))
            bullet.position.x = self.position.x+100
            direction = self.position.x+bulletRange
        }
        scene.addChild(bullet)
        let moveBulletAction = SKAction.move(to: CGPoint(x:direction, y: self.position.y), duration: 1)
        let removeBulletAction = SKAction.removeFromParent()
        bullet.run(SKAction.sequence([moveBulletAction,removeBulletAction]))
    }


}
