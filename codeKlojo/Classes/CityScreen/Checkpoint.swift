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
    1000 : "School",
    3000 : "Winkel",
    5000 : "Achtbaan"
]

class Checkpoint: CityLevel{
    
    func check(playerPosition: CGPoint)->Bool{
        
        for (position, _) in cps {
            let playerX = Int(playerPosition.x)
            
            if(playerX > position){
                
                // Remove checkpoint from array
                cps.removeValue(forKey: position)
                return true
            }
        };return false
    }
    
}

