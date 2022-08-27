//
//  GameScene+PhysicsContact.swift
//  side-scroller
//
//  Created by russell martinez on 8/26/22.
//

import SpriteKit

extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact){
        
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if(collision == (PhysicsCategory.player | PhysicsCategory.collectable))
        {
            let collectableNode = (contact.bodyA.node?.name == "collectable") ?
                contact.bodyA.node! as SKNode :
                contact.bodyB.node! as SKNode
        
            addToScore(points: 5)
            collectableNode.removeFromParent()
        }
    }
}
