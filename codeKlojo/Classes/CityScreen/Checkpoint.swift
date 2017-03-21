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
    cps(position: 3100, title: "Voorbeeldopdracht: Rekenen", explanation: "Met een programmeertaal kun je heel gemakkelijk de moeilijkste rekensommen oplossen. \nZorg dat de uitkomst van alle rekensommen 10 is", setup: "var plus = 4+3", answer: "10"),
    cps(position: 8000, title: "Opdracht 2 (School) - If/Else", explanation: "Blackhat heeft de tijden van de schoolbel aangepast. Pas de tijd aan naar 15:00", setup: "var begintijd = 8:30 \nvar eindtijd = 17:00 \nif(huidige_tijd == eindtijd){ \n    schoolBel() \n}", answer: "15:00")
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

