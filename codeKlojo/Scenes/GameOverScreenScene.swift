//
//  GameOverScreenScene.swift
//  codeKlojo
//
//  Created by Tim Bartels on 23-11-16.
//  Copyright © 2016 Tim Bartels. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameOverScreenScene: SKScene {
    let textLabel = UILabel()
    
    override func sceneDidLoad() {
        
    }
    
    override func didMove(to view: SKView) {
        self.backgroundColor = SKColor(red: CGFloat(188.0/255.0), green: CGFloat(228.0/255.0), blue: CGFloat(227.0/255.0), alpha: 0)
        initText()
    }
    
    func initText(){
        textLabel.text = "Game over"
        textLabel.font = UIFont(name: "RifficFree-Bold", size: 50)
        textLabel.textColor = UIColor.white
        textLabel.textAlignment = NSTextAlignment.center
        textLabel.frame = CGRect(x: 0, y: (frame.size.height/2), width: frame.size.width, height: 50)
        self.view?.addSubview(textLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    
    override func update(_ currentTime: CFTimeInterval) {
        
    }
}
