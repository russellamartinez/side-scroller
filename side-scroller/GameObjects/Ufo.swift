//
//  Ufo.swift
//  side-scroller
//
//  Created by russell martinez on 8/30/22.
//

import SpriteKit

class Ufo : SKSpriteNode
{
    convenience init()
    {
        self.init(imageNamed: "ufo")
        self.name = "ufo"
        self.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(8.0))
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.contactTestBitMask = PhysicsCategory.player | PhysicsCategory.collectable
        self.physicsBody?.categoryBitMask = PhysicsCategory.ufo
    }
}
