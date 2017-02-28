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
    var positionx   =   CGFloat()
    var positiony   =   CGFloat()
    var width       =   CGFloat()
    var height      =   CGFloat()
    var jumpThrough =   Bool()
    var added       =   Bool()
    
    func load(){
        let platform1 = Platform()
        platform1.positionx   =   3840
        platform1.positiony   =   180
        platform1.width       =   50
        platform1.height      =   70
        platform1.jumpThrough =   true
        platform1.added       =   false
        
        Platforms.append(platform1)
        
        let platform2 = Platform()
        platform2.positionx   =   3885
        platform2.positiony   =   310
        platform2.width       =   500
        platform2.height      =   5
        platform2.jumpThrough =   true
        platform2.added       =   false
        
        Platforms.append(platform2)
        
        let platform3 = Platform()
        platform3.positionx   =   4070
        platform3.positiony   =   440
        platform3.width       =   300
        platform3.height      =   5
        platform3.jumpThrough =   true
        platform3.added       =   false
        
        Platforms.append(platform3)
        
        let platform4 = Platform()
        platform4.positionx   =   4400
        platform4.positiony   =   355
        platform4.width       =   400
        platform4.height      =   5
        platform4.jumpThrough =   true
        platform4.added       =   false
        
        Platforms.append(platform4)
        
        let platform5 = Platform()
        platform5.positionx   =   4830
        platform5.positiony   =   265
        platform5.width       =   180
        platform5.height      =   5
        platform5.jumpThrough =   true
        platform5.added       =   false
        
        Platforms.append(platform5)
        
        let platform6 = Platform()
        platform6.positionx   =   5230
        platform6.positiony   =   265
        platform6.width       =   180
        platform6.height      =   5
        platform6.jumpThrough =   true
        platform6.added       =   false
        
        Platforms.append(platform6)
        
    }
}
