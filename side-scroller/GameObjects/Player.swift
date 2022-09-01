//
//  Player.swift
//  side-scroller
//
//  Created by russell martinez on 8/31/22.
//

import Foundation
import SpriteKit

class Player : SKSpriteNode
{
    convenience init()
    {
        self.init(imageNamed: "blue-marble")
        self.physicsBody = SKPhysicsBody(circleOfRadius: 8)
        self.physicsBody?.affectedByGravity = true;
        self.physicsBody?.contactTestBitMask = PhysicsCategory.wall
        self.physicsBody?.categoryBitMask = PhysicsCategory.player
    }
}
