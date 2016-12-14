//
//  Responsive.swift
//  codeKlojo
//
//  Created by Tim Bartels on 14-11-16.
//  Copyright © 2016 Tim Bartels. All rights reserved.
//

import Foundation
import UIKit

struct Responsive{
    static let bounds = UIScreen.main.bounds
    static func setHeightScreen(bounds: CGRect) -> CGFloat{
        let height = bounds.size.height
        return height
    }
    static func getHeightScreen() -> CGFloat {
        return setHeightScreen(bounds: Responsive.bounds)
    }
    static func setWidthScreen(bounds: CGRect) -> CGFloat{
        let width = bounds.size.width
        return width
    }
    static func getWidthScreen() -> CGFloat {
        return setWidthScreen(bounds: Responsive.bounds)
    }
    
}
