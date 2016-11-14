//
//  Responsive.swift
//  codeKlojo
//
//  Created by Tim Bartels on 14-11-16.
//  Copyright © 2016 Tim Bartels. All rights reserved.
//

import Foundation
import UIKit

class Responsive{
    let bounds = UIScreen.main.bounds
    func setHeightScreen(bounds: CGRect) -> CGFloat{
        let height = bounds.size.height
        return height
    }
    func getHeightScreen() -> CGFloat {
        return setHeightScreen(bounds: bounds)
    }
    func setWidthScreen(bounds: CGRect) -> CGFloat{
        let width = bounds.size.width
        return width
    }
    func getWidthScreen() -> CGFloat {
        return setWidthScreen(bounds: bounds)
    }
    
}
