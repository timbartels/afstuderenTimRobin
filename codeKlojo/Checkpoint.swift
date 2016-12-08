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
    200 : "School",
    400 : "Winkel",
    600 : "Achtbaan"
]

class Checkpoint {
    
    func check(playerPosition: CGPoint){
        
        for (position, mission) in cps {
            let playerX = Int(playerPosition.x)
            
            if(playerX > position){
                
                print("Positie speler: \(playerX) - CheckPoint: \(position)")
                
                // Show mission screen
                print(mission)
                //let vc = MissionViewController() //change this to your class name
                //self.present(vc, animated: true, completion: nil)
                
                // Remove checkpoint from array
                cps.removeValue(forKey: position)
                
            }
        }
    }
    
}

