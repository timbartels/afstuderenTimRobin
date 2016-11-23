//
//  Background.swift
//  codeKlojo
//
//  Created by Tim Bartels on 10-11-16.
//  Copyright © 2016 Tim Bartels. All rights reserved.
//

import Foundation
import SpriteKit

class Background:SKSpriteNode {
    let responsive = Responsive()
    func load(){
        self.anchorPoint = CGPoint(x: 0,y: 0)
        self.position = CGPoint(x: 0, y: 0)
        self.size.height = responsive.getHeightScreen()
        self.zPosition = -99
    }
}
