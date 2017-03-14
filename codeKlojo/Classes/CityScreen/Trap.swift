//
//  Trap.swift
//  codeKlojo
//
//  Created by Robin Woudstra on 14-03-17.
//  Copyright © 2017 Tim Bartels. All rights reserved.
//

import Foundation
import SpriteKit


var Traps = [Trap()]

class Trap {
    var positionx   =   CGFloat()
    var positiony   =   CGFloat()
    var width       =   CGFloat()
    
    func load(){
        let trap1 = Trap()
        trap1.positionx   =   5030
        trap1.positiony   =   300
        trap1.width       =   160
        
        Traps.append(trap1)
        
    }
}
