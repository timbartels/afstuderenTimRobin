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
        print(diff)
        if -(maxRange) ... -(minRange) ~= diff{
            self.run(SKAction.moveBy(x: -5, y:0, duration: 0.2))
            self.xScale = (enemySize)
        }else if minRange ... maxRange ~= diff{
            self.run(SKAction.moveBy(x: 5, y:0, duration: 0.2))
            self.xScale = -(enemySize)
        }
    }

}
