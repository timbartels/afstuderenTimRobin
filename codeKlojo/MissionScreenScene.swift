//
//  MissionScreenScene.swift
//  codeKlojo
//
//  Created by Tim Bartels on 12-12-16.
//  Copyright © 2016 Tim Bartels. All rights reserved.
//

import SpriteKit
import UIKit

class MissionScreenScene: SKScene, SceneManager {
    
    override func sceneDidLoad() {
    }
    
    override func didMove(to view: SKView) {
        // Init background
        self.backgroundColor = SKColor(red: CGFloat(116.0/255.0), green: CGFloat(226.0/255.0), blue: CGFloat(207.0/255.0), alpha: 0)
        self.addChild(Background().load().first!)
        
        //Init textfield
        let textField = UITextView(frame: CGRect(x: self.frame.width/2, y: 0, width: self.frame.width/2, height: self.frame.height))
        textField.backgroundColor = UIColor.black
        textField.textColor = UIColor.green
        textField.font = UIFont(name: "Glass_TTY_VT220", size: 30)
        textField.textContainerInset = UIEdgeInsetsMake(30, 30, 30, 30)
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.becomeFirstResponder()
        textField.spellCheckingType = .no
        self.view!.addSubview(textField)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for view in (self.view?.subviews)!{
            view.removeFromSuperview()
        }
        loadScene(withIdentifier: .game)
    }
    
    
    override func update(_ currentTime: CFTimeInterval) {
        
    }

}
