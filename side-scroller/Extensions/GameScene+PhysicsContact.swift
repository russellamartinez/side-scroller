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
      
            if(Bool.random())
            {
                camera!.run(camera!.GetCameraZoomSequence())
            }else{
                camera!.run(camera!.GetCameraRotationSequence())
            }
        }
        
        if(collision == (PhysicsCategory.ufo | PhysicsCategory.collectable))
        {
            let collectableNode = (contact.bodyA.node?.name == "collectable") ?
                contact.bodyA.node! as SKNode :
                contact.bodyB.node! as SKNode
        
            addToScore(points: -3)
            collectableNode.removeFromParent()
      
            if(Bool.random())
            {
                camera!.run(camera!.GetCameraZoomSequence())
            }else{
                camera!.run(camera!.GetCameraRotationSequence())
            }
        }
        
        if(collision == (PhysicsCategory.player | PhysicsCategory.fireball))
        {
            resetGame()
        }
        
        if(collision == (PhysicsCategory.player | PhysicsCategory.ufo))
        {
            resetGame()
        }
    }
}
