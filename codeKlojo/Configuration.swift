//
//  Configuration.swift
//  codeKlojo
//
//  Created by Tim Bartels on 12-12-16.
//  Copyright © 2016 Tim Bartels. All rights reserved.
//

import CoreGraphics

struct Levels {
    static var levelsDictionary = [String:Any]()
}

struct ZPosition {
    static let background: CGFloat = 0
    static let obstacles: CGFloat = 1
    static let bird: CGFloat = 2
    static let hudBackground: CGFloat = 10
    static let hudLabel: CGFloat = 11
}

struct PhysicsCategory {
    static let none: UInt32 = 0
    static let all: UInt32 = UInt32.max
    static let edge: UInt32 = 0x1
    static let player : UInt32 = 0x1 << 1
    static let bullet : UInt32 = 0x1 << 2
    static let enemy : UInt32 = 0x1 << 3
    static let flag : UInt32 = 0x1 << 4
    
}

extension CGPoint {
    
    static public func + (left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x + right.x, y: left.y + right.y)
    }
    
    static public func - (left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x - right.x, y: left.y - right.y)
    }

    static public func * (left: CGPoint, right: CGFloat) -> CGPoint {
        return CGPoint(x: left.x * right, y: left.y * right)
    }
}

struct Position {
    static var saved = CGPoint(x: 100, y: 125)
}
    
