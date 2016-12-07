//
//  Checkpoint.swift
//  codeKlojo
//
//  Created by Robin Woudstra on 07-12-16.
//  Copyright © 2016 Tim Bartels. All rights reserved.
//

import Foundation
import SpriteKit

class Checkpoint {
    var checkPoints = [200,2500,3500]
    
    func check(playerPosition: CGPoint){
        
        let playerX = Int(playerPosition.x)
        for (index, checkpoint) in checkPoints.enumerated() {
            if(playerX > checkpoint){
                
                // Show mission screen
                showMissionScreen(screen: index)
                
                // Remove checkpoint from array
                removeCheckPoint(check: index)
                
            }
        }
    }
    
    func removeCheckPoint(check: Int){
        checkPoints.remove(at: check)
        print(checkPoints)
    }
    
    func showMissionScreen(screen: Int){
        
    }
}

