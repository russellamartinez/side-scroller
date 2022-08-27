//
//  PhysicsCategory.swift
//  side-scroller
//
//  Created by russell martinez on 8/26/22.
//
import SpriteKit

enum PhysicsCategory {
    static let none:            UInt32 = 0
    static let player:          UInt32 = 0b1        // 1
    static let wall:            UInt32 = 0b10       // 2
    static let collectable:     UInt32 = 0b100      // 3
}
