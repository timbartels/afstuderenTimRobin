//
//  Global.swift
//  codeKlojo
//
//  Created by Tim Bartels on 12-12-16.
//  Copyright © 2016 Tim Bartels. All rights reserved.
//

import Foundation
import SpriteKit

struct Global {
    // Save the position of the player globally so it wont be affected
    static var savedPosition = CGPoint(x: 2500, y: 125)
    
    // Save the position of the floor globally so it can be used for calculations
    static var floorPosition = CGPoint()
}

struct PhysicsCategory {
    static let player : UInt32 = 1
    static let bullet : UInt32 = 2
    static let enemy : UInt32 = 3
}
