//
//  Platforms.swift
//  codeKlojo
//
//  Created by Robin Woudstra on 16-02-17.
//  Copyright © 2017 Tim Bartels. All rights reserved.
//

import Foundation
import SpriteKit


var Platforms = [Platform()]

class Platform {
    var positionx = CGFloat()
    var positiony = CGFloat()
    var width     = CGFloat()
    var height    = CGFloat()
    var added  = Bool()
    
    func load(){
        let platform1 = Platform()
        platform1.positionx =   3840
        platform1.positiony =   180
        platform1.width     =   50
        platform1.height    =   70
        platform1.added     =   false
        
        Platforms.append(platform1)
        
        let platform2 = Platform()
        platform2.positionx =   3885
        platform2.positiony =   280
        platform2.width     =   500
        platform2.height    =   50
        platform2.added     =   false
        
        Platforms.append(platform2)
        
        let platform3 = Platform()
        platform3.positionx =   4070
        platform3.positiony =   410
        platform3.width     =   300
        platform3.height    =   50
        platform3.added     =   false
        
        Platforms.append(platform3)
        
    }
}
