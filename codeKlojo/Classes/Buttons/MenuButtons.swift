//
//  MenuButtons.swift
//  codeKlojo
//
//  Created by Tim Bartels on 14-12-16.
//  Copyright © 2016 Tim Bartels. All rights reserved.
//


import SpriteKit
import UIKit

class MenuButtons: Buttons{
    func loadResumeButton(button: UIButton){
        prepareButtonController(imageName: "ResumeButton", button: button)
        button.frame = CGRect(x: width/2-70, y: height/2, width: 200, height: 70)
    }
    func loadMuteButton(button: UIButton){
        prepareButtonController(imageName: "MuteButton", button: button)
        button.frame = CGRect(x: width/2-70, y: height/2-100, width: 200, height: 70)
    }
    
    func loadStartButton(button: UIButton){
        prepareButtonController(imageName: "HomeButton", button: button)
        button.frame = CGRect(x: width/2-70, y: height/2-200, width: 200, height: 70)
    }
}
