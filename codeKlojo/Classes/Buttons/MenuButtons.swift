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
    func loadResumeButton(button: UIButton, view: UIView){
        prepareButtonController(imageName: "ResumeButton", button: button)
        button.frame = CGRect(x: width/2-70, y: height/2, width: 200, height: 70)
        view.addSubview(button)
    }
    func loadMuteButton(button: UIButton, view: UIView){
        prepareButtonController(imageName: "MuteButton", button: button)
        button.frame = CGRect(x: width/2-70, y: height/2-100, width: 200, height: 70)
        view.addSubview(button)
    }
    
    func loadStartButton(button: UIButton, view: UIView){
        prepareButtonController(imageName: "HomeButton", button: button)
        button.frame = CGRect(x: width/2-70, y: height/2-200, width: 200, height: 70)
        view.addSubview(button)
    }
}
