//
//  SKNode+Extensions.swift
//  codeKlojo
//
//  Created by Tim Bartels on 05/12/2019.
//  Copyright © 2019 Tim Bartels. All rights reserved.
//

import SpriteKit

extension SKNode {
    func aspectScale(to size: CGSize, width: Bool, multiplier: CGFloat){
        let scale = width ? (size.width * multiplier) / self.frame.size.width : (size.height * multiplier) / self.frame.size.height
        self.setScale(scale)
    }
}
