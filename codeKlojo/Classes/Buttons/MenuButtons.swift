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
        let image = UIImage(named: "button") as UIImage?
        button.setImage(image, for: .normal)
        button.frame = CGRect(x: width/2, y: height/2, width: 80, height: 80)
        button.transform = CGAffineTransform(rotationAngle: -CGFloat.pi )
    }
    func loadMuteButton(button: UIButton){
        let image = UIImage(named: "button") as UIImage?
        button.setImage(image, for: .normal)
        button.frame = CGRect(x: width/2, y: height/2-100, width: 80, height: 80)
        button.transform = CGAffineTransform(rotationAngle: -CGFloat.pi )
    }
    
    func loadStartButton(button: UIButton){
        let image = UIImage(named: "button") as UIImage?
        button.setImage(image, for: .normal)
        button.frame = CGRect(x: width/2, y: height/2-200, width: 80, height: 80)
        button.transform = CGAffineTransform(rotationAngle: -CGFloat.pi )
    }
}
