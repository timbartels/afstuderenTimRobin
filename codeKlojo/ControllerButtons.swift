//
//  ControllerButtons.swift
//  codeKlojo
//
//  Created by Tim Bartels on 10-11-16.
//  Copyright © 2016 Tim Bartels. All rights reserved.
//

import Foundation
import SpriteKit

class Buttons{
    var buttonStateR = false
    var buttonStateL = false
    
    func loadButtonRight(button: UIButton) {
        button.setTitle("\u{27A1}", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.frame = CGRect(x: 150, y: 600, width: 50, height: 50)
        button.addTarget(self, action: #selector(ButtonDownR), for: .touchDown)
        button.addTarget(self, action: #selector(ButtonUpR), for: .touchUpInside)
    }
    func loadButtonLeft(button: UIButton) {
        button.setTitle("\u{2B05}", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.frame = CGRect(x: 50, y: 600, width: 50, height: 50)
        button.addTarget(self, action: #selector(ButtonDownL), for: .touchDown)
        button.addTarget(self, action: #selector(ButtonUpL), for: .touchUpInside)
    }
    
    @objc func ButtonDownR(sender:UIButton) {
        buttonStateR = true
    }
    
    @objc func ButtonUpR(sender:UIButton) {
        buttonStateR = false
    }
    
    @objc func ButtonDownL(sender:UIButton) {
        buttonStateL = true
    }
    
    @objc func ButtonUpL(sender:UIButton) {
        buttonStateL = false
    }
}
