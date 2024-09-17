//
//  String+Extensions.swift
//  codeKlojo
//
//  Created by Tim Bartels on 09/12/2019.
//  Copyright © 2019 Tim Bartels. All rights reserved.
//

import Foundation

extension String {
    var digits: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
    }
}
