//
//  AnimationHelper.swift
//  codeKlojo
//
//  Created by Tim Bartels on 05/12/2019.
//  Copyright © 2019 Tim Bartels. All rights reserved.
//

import SpriteKit

class AnimationHelper {
    
    static func loadTextures(from atlas: SKTextureAtlas, withName name: String) -> [SKTexture] {
        var textures = [SKTexture]()
        
        for index in 0..<atlas.textureNames.count {
            let textureName = name + String(index+1)
            textures.append(atlas.textureNamed(textureName))
        }
        return textures
    }
}

