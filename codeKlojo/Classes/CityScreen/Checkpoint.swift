//
//  Checkpoint.swift
//  codeKlojo
//
//  Created by Robin Woudstra on 07-12-16.
//  Copyright © 2016 Tim Bartels. All rights reserved.
//

import Foundation
import SpriteKit

var cps: [Int:String] = [
    3100 : "Test",
    8000 : "School",
]

class Checkpoint: CityLevel{
    
    var cp : String = "empty"
    
    func check(playerPosition: CGPoint)->String{
        
        for (position, mission) in cps {
            let playerX = Int(playerPosition.x)
            
            if(playerX > position){
                
                cp = mission
                
                // Remove checkpoint from array
                cps.removeValue(forKey: position)
                
                // Set latest checkpoint
                Global.savedPosition = CGPoint(x: position, y: 165)
                
            }
        }
        return cp
    }
}

