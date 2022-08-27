//
//  SKTileMapNode+TileAppend.swift
//  side-scroller
//
//  Created by russell martinez on 8/26/22.
//
import SpriteKit

extension SKTileMapNode {
    
    func generateGems(){
        for col in 0..<numberOfColumns {
            for row in 0..<numberOfRows {
                if let td = tileDefinition(atColumn: col, row: row){
                    
                    let tilePosition = centerOfTile(atColumn: col, row: row)
                    
                    if((td.name!.starts(with: "up-edge")))
                    {
                        let collectable = SKSpriteNode(imageNamed: "gem-bouncing-1")
                        collectable.name = "collectable"
                        collectable.position = tilePosition
                        collectable.position.y += 16
                        collectable.physicsBody = SKPhysicsBody(circleOfRadius: 8)
                        collectable.physicsBody?.affectedByGravity = false
                        collectable.physicsBody?.allowsRotation = false
                        collectable.physicsBody?.isDynamic = false
                        collectable.physicsBody?.contactTestBitMask = PhysicsCategory.player
                        collectable.physicsBody?.categoryBitMask = PhysicsCategory.collectable
                        
                        let gemTextureAtlas = SKTextureAtlas(named: "Gem")
                        var gemTextures : [SKTexture] = []
                        gemTextures.append(gemTextureAtlas.textureNamed("gem-bouncing-1"))
                        gemTextures.append(gemTextureAtlas.textureNamed("gem-bouncing-2"))
                        gemTextures.append(gemTextureAtlas.textureNamed("gem-bouncing-3"))
                        gemTextures.append(gemTextureAtlas.textureNamed("gem-bouncing-4"))
                        gemTextures.append(gemTextureAtlas.textureNamed("gem-bouncing-5"))
                        gemTextures.append(gemTextureAtlas.textureNamed("gem-bouncing-6"))
                        let resting = SKAction.animate(with: gemTextures, timePerFrame: TimeInterval(0.1))
                        collectable.run(SKAction.repeatForever(resting))
                        
                        addChild(collectable)
                    }
                }
            }
        }
    }
}
