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

    
    func loadButtonMenu(button: UIButton, view: UIView) {
        prepareButtonController(imageName: "MenuButton", button: button)
        button.frame = CGRect(x: width-140, y: 30, width: 90, height: 90)
        button.alpha = 1.0
        view.addSubview(button)
    }
    
    func loadButtonLeft(button: UIButton, view: UIView) {
        prepareButtonController(imageName: "button_left", button: button)
        button.frame = CGRect(x: 50, y: height-130, width: 90, height: 90)
        button.alpha = 1.0
        button.addTarget(self, action: #selector(ButtonDownL), for: .touchDown)
        button.addTarget(self, action: #selector(ButtonUpL), for: .touchUpInside)
        button.addTarget(self, action: #selector(ButtonUpL), for: .touchUpOutside)
        view.addSubview(button)
    }
    func loadButtonRight(button: UIButton, view: UIView) {
        prepareButtonController(imageName: "button_right", button: button)
        button.frame = CGRect(x: 165, y: height-130, width: 90, height: 90)
        button.alpha = 1.0
        button.addTarget(self, action: #selector(ButtonDownR), for: .touchDown)
        button.addTarget(self, action: #selector(ButtonUpR), for: .touchUpInside)
        button.addTarget(self, action: #selector(ButtonUpR), for: .touchUpOutside)
        view.addSubview(button)
    }
    func loadButtonUp(button: UIButton, view: UIView) {
        prepareButtonController(imageName: "jump", button: button)
        button.alpha = 1.0
        button.frame = CGRect(x: width-255, y: height-130, width: 90, height: 90)
        button.addTarget(self, action: #selector(ButtonDownU), for: .touchDown)
        view.addSubview(button)
    }
    func loadButtonAttack(button: UIButton, view: UIView) {
        prepareButtonController(imageName: "attack", button: button)
        button.alpha = 1.0
        button.frame = CGRect(x: width-140, y: height-130, width: 90, height: 90)
        button.addTarget(self, action: #selector(ButtonDownAttack), for: .touchDown)
        view.addSubview(button)
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
    
// This func not necessary??
//    @objc func ButtonUpU(sender:UIButton) {
//        buttonStateU = false
//    }
    
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
