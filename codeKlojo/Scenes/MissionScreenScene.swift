//
//  CodeScreenScene.swift
//  codeKlojo
//
//  Created by Tim Bartels on 08/12/2019.
//  Copyright © 2019 Tim Bartels. All rights reserved.
//

import SpriteKit
import WebKit

class MissionScreenScene: SKScene {
    var sceneManagerDelegate: SceneManagerDelegate?
    
    let textField = UITextView()
    let webView = WKWebView()
    let syntaxLabel = UILabel()
    var syntaxError: String = ""
    let returnLabel = UILabel()
    let explanationLabel = UITextView()
    let submit = UIButton()
    var mission = Missions.missions[0]
    
    override func didMove(to view: SKView) {
        prepareMission()
        view.addSubview(syntaxLabel)
        view.addSubview(explanationLabel)
        view.addSubview(returnLabel)
        view.addSubview(textField)
        view.addSubview(submit)
    }
    
    func prepareMission() {
        addCodeEditor()
        addErrorField()
        addExplanationField()
        addOutputField()
    }
    
    func addExplanationField() {
        explanationLabel.text = mission.explanation
        explanationLabel.font = UIFont(name: "RifficFree-Bold", size: 20)
        explanationLabel.textColor = UIColor.black
        explanationLabel.backgroundColor = UIColor(red:254.0/255.0, green:247.0/255.0, blue:192.0/255.0, alpha: 1.0)
        explanationLabel.textColor = UIColor.black
        explanationLabel.textAlignment = .left
        explanationLabel.layer.zPosition = 5
        explanationLabel.allowsEditingTextAttributes = false
        explanationLabel.isPagingEnabled = false
        explanationLabel.isEditable = false
        explanationLabel.isSelectable = false
        explanationLabel.frame = CGRect(x: 0, y: 0, width: frame.width/2, height: frame.height/2)
    }
    
    func addCodeEditor() {
        textField.text = mission.setup
        textField.backgroundColor = UIColor.black
        textField.frame = CGRect(x: frame.width/2, y: 0, width: frame.width/2, height: frame.height - 70 )
        textField.textColor = UIColor.white
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.spellCheckingType = .no
        textField.font = UIFont(name: "Courier", size: 18)
        textField.showsVerticalScrollIndicator = true
        textField.layer.zPosition = 2
        textField.addDoneButtonOnKeyboard()
    }
    
    func addErrorField() {
        syntaxLabel.font = UIFont(name: "Courier", size: 18)
        syntaxLabel.textColor = UIColor(red:231.0/255.0, green:121.0/255.0, blue:36.0/255.0, alpha: 1.0)
        syntaxLabel.backgroundColor = UIColor(red:67.0/255.0, green:67.0/255.0, blue:67.0/255.0, alpha: 1.0)
        syntaxLabel.textAlignment = .center
        syntaxLabel.layer.zPosition = 2
        syntaxLabel.frame = CGRect(x: frame.width/2, y: frame.height - 70, width: frame.width/2, height: 70)
        
        submit.frame = CGRect(x: frame.width/2 + 20, y: frame.height - 60, width: 50, height: 50)
        submit.layer.zPosition = 100
        submit.addTarget(self, action: #selector(runCode), for: .touchUpInside)
        submit.setImage(#imageLiteral(resourceName: "playButton"), for: .normal)
    }
    
    func addOutputField() {
        returnLabel.text = ""
        returnLabel.font = UIFont(name: "Courier", size: 40)
        returnLabel.textColor = UIColor.black
        returnLabel.backgroundColor = UIColor(red:254.0/255.0, green:247.0/255.0, blue:192.0/255.0, alpha: 1.0)
        returnLabel.textColor = UIColor.black
        returnLabel.textAlignment = .center
        returnLabel.layer.zPosition = 5
        returnLabel.frame = CGRect(x: 0, y: frame.height/2, width: frame.width/2, height: frame.height/2)
    }
    
    @objc func runCode(sender: UIButton!) {
        let sub1 = "console.log("
        let sub2 = ")"
        let sub3 = "schoolBel()"
       
        if self.textField.text!.contains(sub3) {
            self.textField.text! += "function schoolBel(){ return huidige_tijd; }"
        }else{
            if self.textField.text!.contains(sub2) {
                self.textField.text = self.textField.text.replacingOccurrences(of: sub2, with: "")
            }
            if self.textField.text!.contains(sub1) {
                self.textField.text = self.textField.text.replacingOccurrences(of: sub1, with: "")
            }
        }

        self.webView.evaluateJavaScript(self.textField.text!){ (result, error) in
            var errorCode: Int
            var errorMessage: String
            if error == nil {
                self.syntaxError = "✔︎"
                if result != nil{
                    self.returnLabel.text = "\(result!)"
                    self.checkResult(answer: self.returnLabel.text!)
                }
            } else {
                errorMessage = (error?.localizedDescription)!
                errorCode = (error?._code)!
                self.syntaxError = "\(errorMessage) on line \(errorCode)"
            }
        }
        syntaxLabel.text = syntaxError
    }
    
    func checkResult(answer: String) {
        if answer == mission.answer {
            
            removeAllSubViews()
            sceneManagerDelegate?.presentCityScreenScene()
        }
    }
    
    func removeAllSubViews() {
        for subview in view!.subviews {
            subview.removeFromSuperview()
        }
    }
}
