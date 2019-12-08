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
    
    var checkpoints = [Checkpoint]()
    
    let clouds = Clouds()
    
    var lives: Int = 3
 
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
                    case let name where name.contains("checkpoint"):
                        if let checkpoint = createCheckpoint(from: child, name: name) {
                            mapNode.addChild(checkpoint)
                            child.removeFromParent()
                            checkpoints.append(checkpoint)
                        }
                       
                    default:
                        break
                }
                
                child.removeFromParent()
            }
        }
        
        clouds.load(scene: self, amount: 20)
        
        player.createPhysicsBody()
        player.position = Position.saved        
        player.aspectScale(to: mapNode.tileSize, width: false, multiplier: 4.0)
        player.zPosition = ZPosition.player
        mapNode.addChild(player)
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
    
    func createCheckpoint(from placeholder: SKSpriteNode, name: String) -> Checkpoint? {
        let checkpoint = Checkpoint()
        checkpoint.name = name
        checkpoint.size = placeholder.size
        checkpoint.position = placeholder.position
        checkpoint.zPosition = ZPosition.obstacles
        checkpoint.zRotation = placeholder.zRotation
        return checkpoint
    }

    func goToGameOverScreenScene() {
        sceneManagerDelegate?.presentGameOverScreenScene()
    }
    
    override func update(_ currentTime: CFTimeInterval) {
        checkpoints.forEach { checkpoint in
            checkpoint.check(scene: self, position: player.position)
        }
        enemies.forEach { enemy in
            enemy.attack(scene: self, position: player.position)
        }
    }
}

extension CityScreenScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        let mask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask

        switch mask {
            case PhysicsCategory.player | PhysicsCategory.enemy:
                if player.attackState == true {
                    contact.bodyB.node?.removeFromParent()
                } else {
                    if lives < 1 {
                        goToGameOverScreenScene()
                    }
                    lives = lives - 1
                    
                }
            case PhysicsCategory.player | PhysicsCategory.bullet:
                if lives < 1 {
                    goToGameOverScreenScene()
                }
                lives = lives - 1
            case PhysicsCategory.player | PhysicsCategory.flag:
                break
            default:
                break
        }
    }
}

extension CityScreenScene: ControllerButtonHandlerDelegate {
    func leftTapped(finished: Bool) {
        if finished {
            player.finishedWalking()
        } else {
            player.walkTo(direction: -12)
        }
        
    }
    
    func rightTapped(finished: Bool) {
        if finished {
            player.finishedWalking()
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
