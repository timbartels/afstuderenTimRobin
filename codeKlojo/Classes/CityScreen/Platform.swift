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
        // Trashcan
        let platform1 = Platform()
        platform1.positionx   =   3900
        platform1.positiony   =   165
        platform1.width       =   50
        platform1.height      =   70
        platform1.jumpThrough =   true
        platform1.added       =   false
        
        Platforms.append(platform1)
        
        // Fashion lower
        let platform2 = Platform()
        platform2.positionx   =   3935
        platform2.positiony   =   290
        platform2.width       =   500
        platform2.height      =   5
        platform2.jumpThrough =   true
        platform2.added       =   false
        
        Platforms.append(platform2)
        
        // Fashion top
        let platform3 = Platform()
        platform3.positionx   =   4120
        platform3.positiony   =   417
        platform3.width       =   300
        platform3.height      =   5
        platform3.jumpThrough =   true
        platform3.added       =   false
        
        Platforms.append(platform3)
        
        // Restaurant
        let platform4 = Platform()
        platform4.positionx   =   4450
        platform4.positiony   =   340
        platform4.width       =   400
        platform4.height      =   5
        platform4.jumpThrough =   true
        platform4.added       =   false
        
        Platforms.append(platform4)
        
        // Wall
        let platform5 = Platform()
        platform5.positionx   =   4870
        platform5.positiony   =   290
        platform5.width       =   190
        platform5.height      =   5
        platform5.jumpThrough =   true
        platform5.added       =   false
        
        Platforms.append(platform5)
        
        // Wall
        let platform6 = Platform()
        platform6.positionx   =   5260
        platform6.positiony   =   270
        platform6.width       =   190
        platform6.height      =   5
        platform6.jumpThrough =   true
        platform6.added       =   false
        
        Platforms.append(platform6)
        
        // Fountain lower
        let platform7 = Platform()
        platform7.positionx   =   1163
        platform7.positiony   =   85
        platform7.width       =   230
        platform7.height      =   50
        platform7.jumpThrough =   false
        platform7.added       =   false
        
        Platforms.append(platform7)
        
        // Fountain middle
        let platform8 = Platform()
        platform8.positionx   =   1213
        platform8.positiony   =   158
        platform8.width       =   140
        platform8.height      =   40
        platform8.jumpThrough =   false
        platform8.added       =   false
        
        Platforms.append(platform8)
        
        // Fountain top
        let platform9 = Platform()
        platform9.positionx   =   1248
        platform9.positiony   =   195
        platform9.width       =   75
        platform9.height      =   40
        platform9.jumpThrough =   false
        platform9.added       =   false
        
        Platforms.append(platform9)
        
        // Pion
        let platform10 = Platform()
        platform10.positionx   =   5015
        platform10.positiony   =   175
        platform10.width       =   5
        platform10.height      =   220
        platform10.jumpThrough =   false
        platform10.added       =   false
        
        Platforms.append(platform10)
        
        // Pion
        let platform11 = Platform()
        platform11.positionx   =   5300
        platform11.positiony   =   175
        platform11.width       =   5
        platform11.height      =   145
        platform11.jumpThrough =   false
        platform11.added       =   false
        
        Platforms.append(platform11)
    }
}
