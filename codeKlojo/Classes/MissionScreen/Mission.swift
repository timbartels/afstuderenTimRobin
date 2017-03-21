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
    
    func showMission(){
        print("Laat missie zien voor: \(missie)")
    }
}
