//
//  Buttons.swift
//  codeKlojo
//
//  Created by Tim Bartels on 14-12-16.
//  Copyright © 2016 Tim Bartels. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class Buttons: UIButton{
    let height = Responsive.getHeightScreen()
    let width = Responsive.getWidthScreen()
    
    func prepareButtonController(imageName: String, button: UIButton){
        let image = UIImage(named: imageName) as UIImage?
        button.setImage(image, for: .normal)
    }
    
}
