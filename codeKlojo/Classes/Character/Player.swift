//
//  Player.swift
//  codeKlojo
//
//  Created by Tim Bartels on 23-11-16.
//  Copyright © 2016 Tim Bartels. All rights reserved.
//

import Foundation
import SpriteKit

class Player: Character {
    var gameover = 0
    var lives = 3
    var label = UILabel()
    var liveImage = UIImageView()

    override func load(scene: SKScene) {
        super.load(scene: scene)
        self.position = Global.savedPosition
        // idle stance
        self.animatePlayer(jump: false, move: false)
        self.texture = framesIdle.first
        self.physicsBody?.contactTestBitMask = PhysicsCategory.bullet
        self.physicsBody?.contactTestBitMask = PhysicsCategory.enemy
        self.physicsBody?.categoryBitMask = PhysicsCategory.player
        scene.addChild(self)

    }
    
    func animateMove(l: Bool, r: Bool){
        if (l){
            moveLeft()
        }
        
        if (r){
            moveRight()
        }
        
        if (self.action(forKey: "walking") == nil && self.action(forKey: "jump") == nil) {
            animatePlayer(jump: false, move: true)
        }
    }
    func checkLives(scene: SKScene){
        let positionPlayer = self.position
        let endLine = CGPoint(x: self.position.x, y: 0)
        if (positionPlayer.y <= endLine.y){
            self.load(scene: scene)
            self.lives -= 1
        }
    }
    
    func initLives(view: UIView){
        // Add lives
        let imageName = "live.png"
        let image = UIImage(named: imageName)!
        var livePosition : CGFloat = 0
        
        for i in 1...3{
            let liveImage = UIImageView(image: image)
            liveImage.tag = i
            liveImage.frame = CGRect(x: livePosition+60, y: 20, width: 50, height: 50)
            livePosition += 60
            liveImage.alpha = 1
            view.addSubview(liveImage)
        }
    }
    
    func removeLive(view: UIView){
        // Remove life image
        if (self.lives > 0){
            for _ in 1...3 {
                view.viewWithTag(self.lives+1)?.alpha = 0.7
            }
        }
    }


}
