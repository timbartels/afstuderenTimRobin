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
    
    var lives: Int = 3
    let livesLabel = UILabel()
    let livesHead = UIImage(named: "head")
    var text = NSMutableAttributedString()
 
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        view.showsFPS = true
        view.showsNodeCount = true
        prepareLevel()
        State.status = 1
    }
    
    func prepareLevel(){
        
        if let mapNode = childNode(withName: "Tile Map Node") as? SKTileMapNode {
            self.mapNode = mapNode
        }

        load(mapNode: mapNode)
        
        addCamera()
        
        let controller = Controller(size: frame.size)
        controller.zPosition = ZPosition.hudBackground
        controller.controllerButtonHandlerDelegate = self
        gameCamera.addChild(controller)
        
        clouds.load(scene: self, amount: 20)
        initLives()
    }
    
    func load(mapNode: SKTileMapNode) {
        for child in mapNode.children {
            if let child = child as? SKSpriteNode {
                guard let name = child.name else { continue }
                switch name {
                    case "platform":
                        if let platform = createPlatform(from: child, name: name) {
                            mapNode.addChild(platform)
                            child.removeFromParent()
                        }
                    case "player":
                        player.size = child.size
                        player.xScale = child.xScale
                        player.yScale = child.yScale
                        player.position = Position.saved
                        mapNode.addChild(player)
                       
                        child.removeFromParent()
                    case "robot":
                        if State.status == 0 {
                            if let enemy = createEnemy(from: child, name: name) {
                                Enemies.available.append(enemy)
                                mapNode.addChild(enemy)
                                child.removeFromParent()
                            }
                        } else {
                            for enemy in Enemies.available {
                                enemy.removeFromParent()
                                mapNode.addChild(enemy)
                            }
                        }
                    case let name where name.contains("checkpoint"):
                        if State.status == 0 {
                            if let checkpoint = createCheckpoint(from: child, name: name) {
                                Checkpoints.available.append(checkpoint)
                                mapNode.addChild(checkpoint)
                                child.removeFromParent()
                            }
                        } else {
                            for checkpoint in Checkpoints.available {
                                checkpoint.removeFromParent()
                                mapNode.addChild(checkpoint)
                            }
                        }
                    default:
                        break
                    }
                child.removeFromParent()
            }
        }
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
         enemy.createPhysicsBody()
         return enemy
    }
     
    func createPlatform(from placeholder: SKSpriteNode, name: String) -> Platform? {
        let platform = Platform()
        platform.size = placeholder.size
        platform.position = placeholder.position
        platform.zRotation = placeholder.zRotation
        platform.createPhysicsBody()
        return platform
    }
    
    func createCheckpoint(from placeholder: SKSpriteNode, name: String) -> Checkpoint? {
        let checkpoint = Checkpoint()
        checkpoint.name = name
        checkpoint.size = placeholder.size
        checkpoint.position = placeholder.position
        return checkpoint
    }

    func goToGameOverScreenScene() {
        sceneManagerDelegate?.presentGameOverScreenScene()
    }
    
    func initLives(){
        self.livesLabel.frame = CGRect(x: 110, y: 35, width:200, height: 50)
        let livesHeadImage = UIImageView(image: livesHead!)
        livesHeadImage.frame = CGRect(x: 25, y: 25, width: 80, height: 70)
        self.livesLabel.alpha = 0.0
        livesHeadImage.alpha = 0.0
        
        text = NSMutableAttributedString(
            string: "X\(lives)",
            attributes: [NSAttributedString.Key.font:UIFont(
                name: "RifficFree-Bold",
                size: 45.0)!])
        
        text.addAttribute(
            NSAttributedString.Key.foregroundColor,
            value: UIColor(red:255.0/255.0, green:255.0/255.0, blue:255.0/255.0, alpha: 1.0),
            range: NSRange(location:0,length:2))
        
        text.addAttribute(
            NSAttributedString.Key.strokeColor,
            value: UIColor(red:239.0/255.0, green:173.0/255.0, blue:33.0/255.0, alpha: 1.0),
            range:  NSRange(location: 0,length: 2))
        
        text.addAttribute(
            NSAttributedString.Key.strokeWidth,
            value: -8,
            range: NSRange(location: 0,length: 2))
        
        
        self.livesLabel.attributedText = text
        view?.addSubview(livesLabel)
        view?.addSubview(livesHeadImage)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.livesLabel.alpha = 1.0
        }, completion: { finished in })
        
        UIView.animate(withDuration: 0.3, animations: {
            livesHeadImage.alpha = 1.0
        }, completion: { finished in })
    }
    
    func updateLives(){
        livesLabel.removeFromSuperview()
        initLives()
    }
    
    override func update(_ currentTime: CFTimeInterval) {
        for checkpoint in Checkpoints.available {
            if checkpoint.check(scene: self, position: player.position) == true {
                guard let missionNumber = Int(checkpoint.name!.digits) else { return }
                let mission = Missions.missions[missionNumber]
                Checkpoints.available.removeAll{$0 == checkpoint}
                checkpoint.removeFromParent()
                sceneManagerDelegate?.presentMissionScreenScene(mission: mission)
            }
        }
        Enemies.available.forEach { enemy in
            enemy.attack(scene: self, position: player.position)
        }
        
        if player.position.y < Position.bottomLevel {
            lives = lives - 1
            updateLives()
            player.position = Position.saved
        }
    }
}

extension CityScreenScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        let mask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        switch mask {
            case PhysicsCategory.player | PhysicsCategory.enemy:
                if player.attackState == true {
                    if let enemy = contact.bodyB.node as? Enemy {
                        enemy.removeFromParent()
                    } else if let enemy = contact.bodyA.node as? Enemy {
                        enemy.removeFromParent()
                    }
                } else {
                    lives = lives - 1
                    if lives == 0 {
                        goToGameOverScreenScene()
                    } else {
                        updateLives()
                    }
                }
            case PhysicsCategory.player | PhysicsCategory.bullet:
                if (contact.bodyB.node as? Player) != nil {
                    lives = lives - 1
                }
                if (contact.bodyA.node as? Player) != nil {
                    lives = lives - 1
                }
                if lives == 0 {
                    goToGameOverScreenScene()
                } else {
                    updateLives()
                }
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
