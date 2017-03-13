//
//  Mission.swift
//  codeKlojo
//
//  Created by Robin Woudstra on 02-03-17.
//  Copyright © 2017 Tim Bartels. All rights reserved.
//

import Foundation
import SpriteKit
import WebKit
let screenSize: CGRect = UIScreen.main.bounds
var missie:String = ""

class Mission: NSObject {
    static let sharedInstance = Mission()
    var syntaxError: String = ""
    let textField = UITextView(frame: CGRect(x: 0, y: 50, width: screenSize.width, height: screenSize.height/2))
    let webView = WKWebView()
    let syntaxLabel = UILabel()
    let returnLabel = UILabel()
    
    func load(view: UIView){
        textField.backgroundColor = UIColor.black
        textField.textColor = UIColor.white
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.spellCheckingType = .no
        textField.font = UIFont(name: "Courier", size: 15)
        textField.showsVerticalScrollIndicator = true
        
        syntaxLabel.font = UIFont(name: "Courier", size: 10)
        syntaxLabel.textColor = UIColor.black
        syntaxLabel.backgroundColor = UIColor.green
        syntaxLabel.textAlignment = .center
        syntaxLabel.frame = CGRect(x: 0, y: screenSize.height/2+50, width: screenSize.width, height: 50)
        
        returnLabel.font = UIFont(name: "Courier", size: 20)
        returnLabel.textColor = UIColor.black
        returnLabel.backgroundColor = UIColor.red
        returnLabel.textColor = UIColor.white
        returnLabel.textAlignment = .center
        returnLabel.frame = CGRect(x: 0, y: screenSize.height/2+100, width: screenSize.width, height: 50)
        
        view.addSubview(syntaxLabel)
        view.addSubview(returnLabel)
        view.addSubview(textField)
        
    }
    
    func checkJavascript(sender: UIButton){
        //print(CityScreenScene().view!.textField.text)
        self.webView.evaluateJavaScript(self.textField.text!){ (result, error) in
            var errorCode: Int
            var errorMessage: String
            var errorSyntax: String
            var errorLine: Int
            if error == nil {
                self.syntaxError = "✔︎"
                print(result)
                //self.returnLabel.text = "\(result!)"
            }else{
                let errorTest = (error! as NSError).userInfo
                errorLine = errorTest[AnyHashable("WKJavaScriptExceptionLineNumber")] as! Int
                errorSyntax = errorTest[AnyHashable("WKJavaScriptExceptionMessage")] as! String
                errorMessage = (error?.localizedDescription)!
                errorCode = (error?._code)!
                self.syntaxError = "\(errorSyntax) on line \(errorLine)"
            }
        }
        self.syntaxLabel.text = self.syntaxError
    }
    
    

    
    func showMission(){
        print("Laat missie zien voor: \(missie)")
    }
}
