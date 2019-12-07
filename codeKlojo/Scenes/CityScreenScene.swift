//
//  GameScene.swift
//  codeKlojo
//
//  Created by Tim Bartels on 08-11-16.
//  Copyright © 2016 Tim Bartels. All rights reserved.
//

import SpriteKit
import GameplayKit
import WebKit

class CityScreenScene: SKScene {
   
    var sceneManagerDelegate: SceneManagerDelegate?
    
    var mapNode = SKTileMapNode()

    let gameCamera = GameCamera()
    
    let player = Player()
    
    var enemies = [Enemy]()
    
    let clouds = Clouds()
 
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        view.showsFPS = true
        view.showsNodeCount = true
        prepareLevel()
    }
    
    func prepareLevel(){
        
        if let mapNode = childNode(withName: "Tile Map Node") as? SKTileMapNode {
            self.mapNode = mapNode
        }
        
        addCamera()
        
        let controller = Controller(size: frame.size)
        controller.zPosition = ZPosition.hudBackground
        controller.controllerButtonHandlerDelegate = self
        gameCamera.addChild(controller)
        
        for child in mapNode.children {
            if let child = child as? SKSpriteNode {
                guard let name = child.name else { continue }
                switch name {
                case "player":
                    player.size = child.size
                    player.xScale = child.xScale
                    player.yScale = child.yScale
                    player.position = child.position
                    player.zPosition = ZPosition.obstacles
                    player.zRotation = child.zRotation
                    player.createPhysicsBody()
                    mapNode.addChild(player)
                    child.removeFromParent()
                case "platform":
                    if let platform = createPlatform(from: child, name: name) {
                        mapNode.addChild(platform)
                        child.removeFromParent()
                    }
                case "robot":
                    if let enemy = createEnemy(from: child, name: name) {
                        mapNode.addChild(enemy)
                        child.removeFromParent()
                        enemies.append(enemy)
                    }
                    
                default:
                    break
                }
                
                child.removeFromParent()
            }
        }
        
        let physicsRect = CGRect(x: 0, y: mapNode.tileSize.height, width: mapNode.frame.size.width, height: mapNode.frame.size.height - mapNode.tileSize.height)
        physicsBody = SKPhysicsBody(edgeLoopFrom: physicsRect)
        physicsBody?.categoryBitMask = PhysicsCategory.edge
        physicsBody?.collisionBitMask = PhysicsCategory.all
        
        clouds.load(scene: self, amount: 20)
        
    }
    
    func addCamera() {
        addChild(gameCamera)
        camera = gameCamera
        gameCamera.setConstraints(with: self, and: mapNode.frame, to: player)
    }
    
    func calculateCamera(){
        guard let view = view else { return }
        gameCamera.position = CGPoint(x: player.position.x, y: view.bounds.size.height/2)
        gameCamera.setConstraints(with: self, and: mapNode.frame, to: nil)
    }
    
    func createEnemy(from placeholder: SKSpriteNode, name: String) -> Enemy? {
         guard let type = EnemyType(rawValue: name) else { return nil }
         let enemy = Enemy(type: type)
         enemy.size = placeholder.size
         enemy.position = placeholder.position
         enemy.zPosition = ZPosition.obstacles
         enemy.zRotation = placeholder.zRotation
         enemy.createPhysicsBody()
         return enemy
     }
     
     func createPlatform(from placeholder: SKSpriteNode, name: String) -> Platform? {
         let platform = Platform()
         platform.size = placeholder.size
         platform.position = placeholder.position
         platform.zPosition = ZPosition.obstacles
         platform.zRotation = placeholder.zRotation
         platform.createPhysicsBody()
         return platform
     }

    func goToGameOverScreenScene() {
        sceneManagerDelegate?.presentMenuScene()
    }
    
    override func update(_ currentTime: CFTimeInterval) {
        enemies.forEach { enemy in
            enemy.attack(scene: self, position: player.position)
        }
    }
}

extension CityScreenScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        let mask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask

        switch mask {
        default:
            break
        }
    }
}

extension CityScreenScene: ControllerButtonHandlerDelegate {
    func leftTapped(finished: Bool) {
        if finished {
            player.removeAction(forKey:"walking")
        } else {
            player.walkTo(direction: -12)
        }
        
        
    }
    
    func rightTapped(finished: Bool) {
        if finished {
            player.removeAction(forKey:"walking")
        } else {
            player.walkTo(direction: 12)
        }
       
    }
    
    func upTapped() {
        player.jump()
    }
    
    func attackTapped() {
        player.attack()
    }
    
}
