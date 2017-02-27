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
        button.frame = CGRect(x: width-200, y: 10, width: 200, height: 80)
        button.alpha = 0.5
        view.addSubview(button)
    }
    
    func loadButtonRight(button: UIButton, view: UIView) {
        prepareButtonController(imageName: "button", button: button)
        button.frame = CGRect(x: width-300, y: height-100, width: 80, height: 80)
        button.alpha = 0.5
        button.transform = CGAffineTransform(rotationAngle: -CGFloat.pi )
        button.addTarget(self, action: #selector(ButtonDownR), for: .touchDown)
        button.addTarget(self, action: #selector(ButtonUpR), for: .touchUpInside)
        button.addTarget(self, action: #selector(ButtonUpR), for: .touchUpOutside)
        view.addSubview(button)
    }
    func loadButtonUp(button: UIButton, view: UIView) {
        prepareButtonController(imageName: "button", button: button)
        button.alpha = 0.5
        button.frame = CGRect(x: width-200, y: height-100, width: 80, height: 80)
        button.transform = CGAffineTransform(rotationAngle: CGFloat.pi/2 )
        button.addTarget(self, action: #selector(ButtonDownU), for: .touchDown)
        view.addSubview(button)
        
    }
    func loadButtonAttack(button: UIButton, view: UIView) {
        prepareButtonController(imageName: "button", button: button)
        button.alpha = 0.5
        button.frame = CGRect(x: width-100, y: height-100, width: 80, height: 80)
        button.transform = CGAffineTransform(rotationAngle: CGFloat.pi )
        button.addTarget(self, action: #selector(ButtonDownAttack), for: .touchDown)
        view.addSubview(button)
        
    }
    func loadButtonLeft(button: UIButton, view: UIView) {
        prepareButtonController(imageName: "button", button: button)
        button.frame = CGRect(x: 50, y: height-100, width: 80, height: 80)
        button.alpha = 0.5
        button.addTarget(self, action: #selector(ButtonDownL), for: .touchDown)
        button.addTarget(self, action: #selector(ButtonUpL), for: .touchUpInside)
        button.addTarget(self, action: #selector(ButtonUpL), for: .touchUpOutside)
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
