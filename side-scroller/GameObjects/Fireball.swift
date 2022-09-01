//
//  Player.swift
//  side-scroller
//
//  Created by russell martinez on 8/31/22.
//

import SpriteKit

class Fireball : SKSpriteNode
{
    convenience init()
    {
        self.init(imageNamed: "fireball")
        self.physicsBody = SKPhysicsBody(circleOfRadius: 4)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.contactTestBitMask = PhysicsCategory.player
        self.physicsBody?.categoryBitMask = PhysicsCategory.fireball
       
    }
}
