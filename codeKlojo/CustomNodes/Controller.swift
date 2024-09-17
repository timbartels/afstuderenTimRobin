//
//  ControllerButtons.swift
//  codeKlojo
//
//  Created by Tim Bartels on 10-11-16.
//  Copyright © 2016 Tim Bartels. All rights reserved.
//

import SpriteKit

protocol ControllerButtonHandlerDelegate {
    func leftTapped(finished: Bool)
    func rightTapped(finished: Bool)
    func upTapped()
    func attackTapped()
}

struct ControllerButtons {
    static let left = 0
    static let right = 1
    static let up = 2
    static let attack = 3
}

class Controller: SKSpriteNode {
    var controllerButtonHandlerDelegate: ControllerButtonHandlerDelegate?
    
    init(size: CGSize) {
        super.init(texture: nil, color: UIColor.clear, size: size)
        setupController()
    }
    
    func setupController() {
        let leftButton = SpriteKitButton(defaultButtonImage: "button_left", action: controllerButtonHandler, index: ControllerButtons.left)
        let rightButton = SpriteKitButton(defaultButtonImage: "button_right", action: controllerButtonHandler, index: ControllerButtons.right)
        let upButton = SpriteKitButton(defaultButtonImage: "jump", action: controllerButtonHandler, index: ControllerButtons.up)
        let attackButton = SpriteKitButton(defaultButtonImage: "attack", action: controllerButtonHandler, index: ControllerButtons.attack)
        
        leftButton.aspectScale(to: frame.size, width: true, multiplier: 0.1)
        rightButton.aspectScale(to: frame.size, width: true, multiplier: 0.1)
        upButton.aspectScale(to: frame.size, width: true, multiplier: 0.1)
        attackButton.aspectScale(to: frame.size, width: true, multiplier: 0.1)
        
        let buttonWidthOffset = leftButton.size.width/2
        let buttonHeightOffset = leftButton.size.height/2
        let backgroundWidthOffset = frame.size.width/2
        let backgroundHeightOffset = frame.size.height/2
        
        let borderOffset = buttonWidthOffset/2

        leftButton.position = CGPoint(x: -backgroundWidthOffset + buttonWidthOffset + buttonWidthOffset/2, y: buttonHeightOffset - backgroundHeightOffset + borderOffset)
        rightButton.position = CGPoint(x: -backgroundWidthOffset + buttonWidthOffset + rightButton.size.width + borderOffset*2, y: buttonHeightOffset - backgroundHeightOffset + borderOffset)
        attackButton.position = CGPoint(x: backgroundWidthOffset - buttonWidthOffset - borderOffset, y: buttonHeightOffset -
            backgroundHeightOffset + borderOffset)
        upButton.position = CGPoint(x: backgroundWidthOffset - rightButton.size.width - buttonWidthOffset - borderOffset*2, y: buttonHeightOffset -
        backgroundHeightOffset + borderOffset)
        
        addChild(leftButton)
        addChild(rightButton)
        addChild(upButton)
        addChild(attackButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func controllerButtonHandler(index: Int, finished: Bool) {
        switch index {
        case ControllerButtons.left:
            controllerButtonHandlerDelegate?.leftTapped(finished: finished)
        case ControllerButtons.right:
            controllerButtonHandlerDelegate?.rightTapped(finished: finished)
        case ControllerButtons.up:
            controllerButtonHandlerDelegate?.upTapped()
        case ControllerButtons.attack:
            controllerButtonHandlerDelegate?.attackTapped()
        default:
            break
        }
    }

}
