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
    let level = MissionLevel()
    var backgroundMusic = SoundEngine()
    let background = Background()
    var textField = UITextView()
    
    override func sceneDidLoad() {
    }
    
    override func didMove(to view: SKView) {
        initBackground()
        initMusic()
        initTextField()
    }
    
    func initMusic(){
        backgroundMusic.play(scene: self)
        self.addChild(backgroundMusic)
    }
    
    func initBackground(){
        // Init background
        self.backgroundColor = SKColor(red: CGFloat(116.0/255.0), green: CGFloat(226.0/255.0), blue: CGFloat(207.0/255.0), alpha: 0)
        background.load(scene: self)
    }
    
    func initTextField(){
        //Init textfield
        textField = level.showTextEditor()
        self.view!.addSubview(textField)
        textField.text = "appel = 1"

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    func checkTextEditor(){
        if(textField.text == "appel = 2"){
            backgroundMusic.run(SKAction.stop())
            loadScene(withIdentifier: .cityscreen)
        }
    }
    
    override func update(_ currentTime: CFTimeInterval) {
        checkTextEditor()
    }

}
