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

    override func load() {        
        super.load()
        self.position = Global.savedPosition
        // idle stance
        self.animatePlayer(jump: false, move: false)
        
        self.texture = framesIdle.first

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
    func checkLives(){
        let positionPlayer = self.position
        let endLine = CGPoint(x: self.position.x, y: 0)
        if (positionPlayer.y <= endLine.y){
            self.load()
            self.lives -= 1
            
            
        }
    }
}
