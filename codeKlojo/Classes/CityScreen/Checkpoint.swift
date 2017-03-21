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
    
    func loadIcons(scene: SKScene){
        
        for (index, i) in missions.enumerated() {
            let icon = SKSpriteNode(imageNamed: "mission")
            
            icon.position.x = CGFloat(i.position)
            icon.position.y = Global.floorPosition.y+100
            icon.name = "icon\(index)"
            scene.addChild(icon)
            
            animateIcon(icon: icon)
        }
        
    }
    
    func animateIcon(icon: SKSpriteNode){
        var scale = SKAction.scale(to: 1.2, duration: 1.0)
    
        if icon.xScale > 1.0 {
             scale = SKAction.scale(to: 1.0, duration: 1.0)
        }
        let completion = SKAction.run(){
            self.animateIcon(icon: icon)
        }
        let Sequence = SKAction.sequence([scale, completion])
        icon.run(Sequence)
    }
    
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

