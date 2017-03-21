//
//  Checkpoint.swift
//  codeKlojo
//
//  Created by Robin Woudstra on 07-12-16.
//  Copyright © 2016 Tim Bartels. All rights reserved.
//

import Foundation
import SpriteKit


struct cps{
    let position: Int
    let title: String
    let explanation: String
    let setup: String
    let answer: String
}
var missions: [cps] = [
    cps(position: 3100, title: "Test", explanation: "Uitleg over deze opdracht", setup: "1+2", answer: "4"),
    cps(position: 8000, title: "School", explanation: "We zijn nu bij school ", setup: "5+3", answer: "10")
]

class Checkpoint: CityLevel{
    
    var cp : cps = cps(position: 0, title: "empty", explanation: "empty", setup: "empty", answer: "empty")
    
    func check(playerPosition: CGPoint)->cps{
        
        for (index, i) in missions.enumerated() {
            let playerX = Int(playerPosition.x)
            
            if(playerX > i.position){
                
                cp = i
                
                // Remove checkpoint from array
                missions.remove(at: index)
                // Set latest checkpoint
                Global.savedPosition = CGPoint(x: i.position, y: 165)
                
            }
        }
        return cp
    }
}

