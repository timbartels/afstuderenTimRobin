//
//  MissionLevel.swift
//  codeKlojo
//
//  Created by Tim Bartels on 14-12-16.
//  Copyright © 2016 Tim Bartels. All rights reserved.
//

import Foundation
import SpriteKit

class MissionLevel{
    func showTextEditor()->UITextView{
        let textField = UITextView(frame: CGRect(x: Responsive.getWidthScreen()/2, y: 0, width: Responsive.getWidthScreen()/2, height: Responsive.getHeightScreen()))
        textField.backgroundColor = UIColor.black
        textField.textColor = UIColor.green
        textField.font = UIFont(name: "Glass_TTY_VT220", size: 30)
        textField.textContainerInset = UIEdgeInsetsMake(30, 30, 30, 30)
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.becomeFirstResponder()
        textField.spellCheckingType = .no
        return textField
    }
    
}
