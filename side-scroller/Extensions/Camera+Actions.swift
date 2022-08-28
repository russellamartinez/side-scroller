//
//  Camera+Actions.swift
//  side-scroller
//
//  Created by russell martinez on 8/27/22.
//

import SpriteKit

extension SKCameraNode {
    
    func GetCameraZoomSequence() -> SKAction {
        
        let customAction0 = SKAction.customAction(withDuration: 0.0) {
            node, elapsedTime in
            if let node = node as? SKCameraNode {
                node.setScale(1.0)
            }
        }
        
        let customAction1 = SKAction.customAction(withDuration: 0.0) {
            node, elapsedTime in
            if let node = node as? SKCameraNode {
                node.setScale(0.95)
            }
        }
        
        let customAction2 = SKAction.customAction(withDuration: 0.0) {
            node, elapsedTime in
            if let node = node as? SKCameraNode {
                node.setScale(0.90)
            }
        }
        
        let customAction3 = SKAction.customAction(withDuration: 0.0) {
            node, elapsedTime in
            if let node = node as? SKCameraNode {
                node.setScale(0.85)
            }
        }
        
        let customAction4 = SKAction.customAction(withDuration: 0.0) {
            node, elapsedTime in
            if let node = node as? SKCameraNode {
                node.setScale(0.80)
            }
        }
        
        let customAction5 = SKAction.customAction(withDuration: 0.0) {
            node, elapsedTime in
            if let node = node as? SKCameraNode {
                node.setScale(0.75)
            }
        }
        
        let animationWait = 0.02
        let sequence = SKAction.sequence([
            customAction1,
            SKAction.wait(forDuration: animationWait),
            customAction2,
            SKAction.wait(forDuration: animationWait),
            customAction3,
            SKAction.wait(forDuration: animationWait),
            customAction4,
            SKAction.wait(forDuration: animationWait),
            customAction5,
            SKAction.wait(forDuration: animationWait),
            customAction5,
            SKAction.wait(forDuration: animationWait),
            customAction4,
            SKAction.wait(forDuration: animationWait),
            customAction3,
            SKAction.wait(forDuration: animationWait),
            customAction2,
            SKAction.wait(forDuration: animationWait),
            customAction1,
            SKAction.wait(forDuration: animationWait),
            customAction0])
        
        return sequence
    }
}
