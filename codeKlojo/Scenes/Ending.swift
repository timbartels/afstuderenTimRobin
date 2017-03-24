//
//  Ending.swift
//  codeKlojo
//
//  Created by Robin Woudstra on 24-03-17.
//  Copyright © 2017 Tim Bartels. All rights reserved.
//

import SpriteKit
import GameplayKit

class EndingScreenScene: SKScene, SceneManager {
    let textLabel = UILabel()
    
    override func sceneDidLoad() {
        
    }
    
    override func didMove(to view: SKView) {
        self.backgroundColor = SKColor(red: CGFloat(188.0/255.0), green: CGFloat(228.0/255.0), blue: CGFloat(227.0/255.0), alpha: 0)
        initText()
    }
    
    func initText(){
        textLabel.text = "Bedankt voor het spelen!"
        textLabel.font = UIFont(name: "RifficFree-Bold", size: 50)
        textLabel.textColor = UIColor.white
        textLabel.textAlignment = NSTextAlignment.center
        textLabel.frame = CGRect(x: 0, y: (Responsive.getHeightScreen()/2), width: (Responsive.getWidthScreen()), height: 50)
        self.view?.addSubview(textLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        loadScene(withIdentifier: .start)
    }
    
    
    override func update(_ currentTime: CFTimeInterval) {
        
    }
}
