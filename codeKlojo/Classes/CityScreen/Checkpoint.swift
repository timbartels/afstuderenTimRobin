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
    let positionX: Int
    let positionY: Int
    let title: String
    let explanation: String
    let setup: String
    let answer: String
}
var missions: [cps] = [
    //Park
    cps(positionX: 600,
        positionY: 150,
        title: "Voorbeeldopdracht: Rekenen",
        explanation: "Met een programmeertaal kun je heel gemakkelijk de moeilijkste rekensommen oplossen. \nZorg dat de uitkomst 10 is.",
        setup: "var plus = 4+3 \nconsole.log(plus)", answer: "10"),
    //Fontein
    cps(positionX: 1100,
        positionY: 150,
        title: "Voorbeeldopdracht: Rekenen",
        explanation: "Met een programmeertaal kun je heel gemakkelijk de moeilijkste rekensommen oplossen. \nZorg dat de uitkomst 15 is.",
        setup: "var min = 23-5 \nconsole.log(min)", answer: "15"),
    //Achterstandswijk
    cps(positionX: 2300,
        positionY: 150,
        title: "Voorbeeldopdracht: Rekenen",
        explanation: "Met een programmeertaal kun je heel gemakkelijk de moeilijkste rekensommen oplossen. \nZorg dat de uitkomst 15 is.",
        setup: "var delen = 10/2 \nconsole.log(delen)", answer: "15"),
    cps(positionX: 3100,
        positionY: 150,
        title: "Voorbeeldopdracht: Rekenen",
        explanation: "Met een programmeertaal kun je heel gemakkelijk de moeilijkste rekensommen oplossen. \nZorg dat de uitkomst 4 is.",
        setup: "var keer = 5*5 \nconsole.log(keer)", answer: "4"),
    //Supermarkt
    cps(positionX: 3550,
        positionY: 150,
        title: "Opdracht 1 (Supermarkt) - Rekenen/Variabelen",
        explanation: "Door Blackhat werken onze kassa's niet meer. Maak een variabele totaalprijs die de prijs van de banaan en appel bij elkaar op telt.",
        setup: "var ananas = 0.60 \nvar aardbei = 1.20 \nvar totaalprijs = aardbei + ananas \n// Maak totaalprijs naar 1.50 \nconsole.log(totaalprijs)",
        answer: "1.5"),
    //Kledingwinkel
    cps(positionX: 4300,
        positionY: 150,
        title: "Opdracht 2 (Kledingwinkel) - Rekenen/Variabelen",
        explanation: "Door Blackhat werken onze kassa's niet meer. Maak een variabele totaalprijs die de prijs van de broek en trui bij elkaar op telt.",
        setup: "var trui = 6.60 \nvar broek = 7.40 \n// Hier moet een variabele \nconsole.log(totaalprijs)",
        answer: "14"),
    //Restaurant
    cps(positionX: 4800,
        positionY: 150,
        title: "Opdracht 2 (Restaurant) - Rekenen/Variabelen",
        explanation: "Door Blackhat werken onze kassa's niet meer en kunnen de pizza's niet goed afrekenen. Zorg dat de pizza's met de door ons berekende prijs overeenkomt",
        setup: "var pizza1 = 6.60 \nvar pizza2 = 10.40 \nvar pizza3 = 7.30 \nvar pizza4 = 13.10 \nvar totaalprijs = 41.00 \ntotaalprijs == pizza1 + pizza2 + pizza3 + pizza4",
        answer: "1"),
    //School
    cps(positionX: 8200,
        positionY: 150,
        title: "Opdracht 2 (School) - If/Else",
        explanation: "Blackhat heeft de tijden van de schoolbel aangepast. Pas de tijd aan naar 15:00.",
        setup: "var huidige_tijd = '15:00'; \nvar begintijd = '8:30'; \nvar eindtijd = '17:00'; \nif(huidige_tijd == eindtijd){ \n    schoolBel(); \n}",
        answer: "15:00")
]

class Checkpoint: CityLevel{
    
    var cp : cps = cps(positionX: 0, positionY: 0, title: "empty", explanation: "empty", setup: "empty", answer: "empty")
    
    func loadIcons(scene: SKScene){
        
        for (_, i) in missions.enumerated() {
            let icon = SKSpriteNode(imageNamed: "mission")
            
            icon.position.x = CGFloat(i.positionX)
            icon.position.y = CGFloat(i.positionY)
            icon.name = "\(i.positionX)"
            icon.setScale(0.5)
            scene.addChild(icon)
            
            animateIcon(icon: icon)
        }
        
    }
    
    func animateIcon(icon: SKSpriteNode){
        var scale = SKAction.scale(to: 1.0, duration: 1.0)
    
        if icon.xScale > 0.5 {
             scale = SKAction.scale(to: 0.5, duration: 1.0)
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
            let playerY = Int(playerPosition.y)
            
            if(playerX > i.positionX && i.positionY-50 < playerY && playerY < i.positionY+50){
                
                cp = i
                
                // Remove checkpoint from array
                missions.remove(at: index)
                
                // Set latest checkpoint
                Global.savedPosition = CGPoint(x: i.positionX, y: i.positionY)
                                
            }
        }
        return cp
    }
}

