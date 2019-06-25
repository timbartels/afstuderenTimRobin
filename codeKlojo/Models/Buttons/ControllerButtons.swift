//
//  ControllerButtons.swift
//  codeKlojo
//
//  Created by Tim Bartels on 10-11-16.
//  Copyright © 2016 Tim Bartels. All rights reserved.
//

import Foundation
import SpriteKit

class ControllerButtons: Buttons{
    var buttonStateR = false
    var buttonStateL = false
    var buttonStateU = false
    var buttonStateAttack = false
    
    func initialize(buttons: Array<UIButton>, view: UIView) {
        for button in buttons {
            loadButton(button: button, view: view)
        }
    }
    
    func loadButton(button: UIButton, view: UIView) {
        prepareButtonController(imageName: button.titleLabel?.text ?? "default", button: button)
        let x : CGFloat
        let y : CGFloat
        switch button.titleLabel?.text {
        case "button_left":
            button.addTarget(self, action: #selector(ButtonDownL), for: .touchDown)
            button.addTarget(self, action: #selector(ButtonUpL), for: .touchUpInside)
            button.addTarget(self, action: #selector(ButtonUpL), for: .touchUpOutside)
            x = 50
            y = height-130
        case "button_right":
            button.addTarget(self, action: #selector(ButtonDownR), for: .touchDown)
            button.addTarget(self, action: #selector(ButtonUpR), for: .touchUpInside)
            button.addTarget(self, action: #selector(ButtonUpR), for: .touchUpOutside)
            x = 165
            y = height-130
        case "jump":
            button.addTarget(self, action: #selector(ButtonDownU), for: .touchDown)
            x = width-255
            y = height-130
        case "attack":
            button.addTarget(self, action: #selector(ButtonDownAttack), for: .touchDown)
            x = width-140
            y = height-130
        case "MenuButton":
            x = width-140
            y = 30
        default:
            x = 0
            y = 0
        }
        button.frame = CGRect(x: x, y: y, width: 90, height: 90)
        button.alpha = 0.0
        view.addSubview(button)
        
        UIView.animate(withDuration: 0.3, animations: {
            button.alpha = 1.0
        }, completion: { finished in })
    }
    
    @objc func ButtonDownR(sender:UIButton) {
        buttonStateR = true
    }
    
    @objc func ButtonUpR(sender:UIButton) {
        buttonStateR = false
    }
    
    @objc func ButtonDownU(sender:UIButton) {
        buttonStateU = true
    }
    
    
    @objc func ButtonDownAttack(sender:UIButton) {
        buttonStateAttack = true
    }
    
    @objc func ButtonDownL(sender:UIButton) {
        buttonStateL = true
    }
    
    @objc func ButtonUpL(sender:UIButton) {
        buttonStateL = false
    }

}
