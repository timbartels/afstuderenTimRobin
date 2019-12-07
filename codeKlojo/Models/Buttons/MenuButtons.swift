//
//  MenuButtons.swift
//  codeKlojo
//
//  Created by Tim Bartels on 14-12-16.
//  Copyright © 2016 Tim Bartels. All rights reserved.
//


import SpriteKit
import UIKit

class MenuButtons: SKSpriteNode{
    func loadResumeButton(button: UIButton, view: UIView){
        button.setTitle("Doorgaan", for: .normal)
        button.titleLabel!.font =  UIFont(name: "RifficFree-Bold", size: 35)
        button.setTitleColor(.white, for: .normal)
        button.alpha = 0.0
        view.addSubview(button)
        
        UIView.animate(withDuration: 0.3, animations: {
            button.alpha = 1.0
        }, completion: { finished in })
    }
    func loadMuteButton(button: UIButton, view: UIView){
        button.setTitle("Geluid dempen", for: .normal)
        button.titleLabel!.font =  UIFont(name: "RifficFree-Bold", size: 35)
        button.setTitleColor(.white, for: .normal)
        button.alpha = 0.0
        view.addSubview(button)
        
        UIView.animate(withDuration: 0.3, animations: {
            button.alpha = 1.0
        }, completion: { finished in })
    }
    
    func loadStartButton(button: UIButton, view: UIView){
        button.setTitle("Startscherm", for: .normal)
        button.titleLabel!.font =  UIFont(name: "RifficFree-Bold", size: 35)
        button.setTitleColor(.white, for: .normal)
        button.alpha = 0.0
        view.addSubview(button)
        
        UIView.animate(withDuration: 0.3, animations: {
            button.alpha = 1.0
        }, completion: { finished in })
    }
}
