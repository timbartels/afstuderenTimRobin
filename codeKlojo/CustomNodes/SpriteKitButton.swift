//
//  SpriteKitButton.swift
//  codeKlojo
//
//  Created by Tim Bartels on 05-12-19.
//  Copyright © 2019 Tim Bartels. All rights reserved.
//

import SpriteKit

class SpriteKitButton: SKSpriteNode {

    var defaultButton: SKSpriteNode
    var action: (Int, Bool) -> ()
    var index: Int
    var finished: Bool
    
    init(defaultButtonImage: String, action: @escaping (Int, Bool) -> (), index: Int) {
        defaultButton = SKSpriteNode(imageNamed: defaultButtonImage)
        self.action = action
        self.finished = true
        self.index = index
        
        super.init(texture: nil, color: UIColor.clear, size: defaultButton.size)
        
        isUserInteractionEnabled = true
        addChild(defaultButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        defaultButton.alpha = 0.75
        finished = false
        action(index, finished)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch: UITouch = touches.first! as UITouch
        let location: CGPoint = touch.location(in: self)
        
        if defaultButton.contains(location) {
            action(index, finished)
        }
        finished = true
        action(index, finished)
        defaultButton.alpha = 1.0
    }

}
