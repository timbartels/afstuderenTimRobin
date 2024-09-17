//
//  Enemy.swift
//  codeKlojo
//
//  Created by Tim Bartels on 13-12-16.
//  Copyright © 2016 Tim Bartels. All rights reserved.
//

import SpriteKit
import Darwin

enum EnemyType: String {
    case robot
}

class Enemy: SKSpriteNode {

    let type: EnemyType
    let minRange = 75
    let maxRange = 400
    let bulletRange = CGFloat(20.0)
    var enemyDirection = "left"
    var inRange = false
    var mayFire = true
    var hit = false
    
    init(type: EnemyType) {
        self.type = type
        switch type {
        case .robot:
            break
        }
        let texture = SKTexture(imageNamed: type.rawValue)
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
    }
    
    func createPhysicsBody() {
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.isDynamic = true
        physicsBody?.categoryBitMask = PhysicsCategory.enemy
        physicsBody?.contactTestBitMask = PhysicsCategory.player
        physicsBody?.collisionBitMask = PhysicsCategory.player | PhysicsCategory.platform
    }

    func attack(scene: SKScene, position: CGPoint){
        self.moveTo(pos: position)
        if self.inRange == true {
            self.invokeFire(scene: scene)
        }
    }
    
    func moveTo(pos: CGPoint){
        inRange = false
        let diff = Int(pos.x) - Int(self.position.x)
        if -(maxRange) ... -(minRange) ~= diff{
            self.run(SKAction.moveBy(x: -5, y:0, duration: 0.5))
            inRange = true
            enemyDirection = "left"
        }else if minRange ... maxRange ~= diff{
            self.run(SKAction.moveBy(x: 5, y:0, duration: 0.5))
            inRange = true
            enemyDirection = "right"
        }
    }
    
    func fireBullet(scene: SKScene){
        let bullet = Bullet()
        bullet.position.x = self.position.x*2
        bullet.position.y = self.position.y + size.height/2
        bullet.setScale(0.4)

        var direction = position.x - bulletRange
        if enemyDirection == "right" {
            bullet.xScale = -(CGFloat(0.5))
            direction = position.x + bulletRange
        }
        scene.addChild(bullet)
        let moveBulletAction = SKAction.move(to: CGPoint(x:direction, y: position.y), duration: 1)
        let removeBulletAction = SKAction.removeFromParent()
        bullet.run(SKAction.sequence([moveBulletAction, removeBulletAction]))
    }
    
    func invokeFire(scene: SKScene){
        let fireBullet = SKAction.run(){
            self.fireBullet(scene: scene)
            self.mayFire = false
        }
        let completion = SKAction.run(){
            self.mayFire = true
        }
        let waitToFireEnemyBullet = SKAction.wait(forDuration: 2.5)
        let enemyFire = SKAction.sequence([fireBullet,waitToFireEnemyBullet,completion])
        
        if self.mayFire == true {
            self.run(enemyFire)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
