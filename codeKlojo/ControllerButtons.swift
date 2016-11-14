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
    let repsonsive = Responsive()
    var buttonStateR = false
    var buttonStateL = false
    
    func loadButtonRight(button: UIButton) {
        let height = repsonsive.getHeightScreen()

        let image = UIImage(named: "button") as UIImage?
        
        button.setImage(image, for: .normal)
        button.frame = CGRect(x: 150, y: height-100, width: 80, height: 80)
        button.alpha = 0.5
        button.transform = CGAffineTransform(rotationAngle: -CGFloat.pi )
        
        button.addTarget(self, action: #selector(ButtonDownR), for: .touchDown)
        button.addTarget(self, action: #selector(ButtonUpR), for: .touchUpInside)
    }
    func loadButtonLeft(button: UIButton) {
        let height = repsonsive.getHeightScreen()
        let image = UIImage(named: "button") as UIImage?
        
        button.setImage(image, for: .normal)
        button.frame = CGRect(x: 50, y: height-100, width: 80, height: 80)
        button.alpha = 0.5
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
