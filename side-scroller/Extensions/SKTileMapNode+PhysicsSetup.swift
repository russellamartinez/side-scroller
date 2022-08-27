//
//  SKTileMapNode+PhysicsSetup.swift
//  side-scroller
//
//  Created by russell martinez on 8/26/22.
//

import SpriteKit

extension SKTileMapNode {
    
    func setupPhysics(){
        for col in 0..<numberOfColumns {
            for row in 0..<numberOfRows {
                if let td = tileDefinition(atColumn: col, row: row){
                    let tilePosition = centerOfTile(atColumn: col, row: row)
                    let wall = SKNode()
                    let cornerWall = SKNode()
                    wall.position = tilePosition
                    cornerWall.position = tilePosition
                    let offset = td.size.height/4
                    
                    if((td.name!.starts(with: "up-edge")))
                    {
                        wall.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: td.size.width, height: td.size.height/2),
                                                         center: CGPoint(x: 0, y: -1*offset))
                        
                    } else if(td.name!.starts(with: "down-edge"))
                    {
                        wall.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: td.size.width, height: td.size.height/2),
                                                         center: CGPoint(x: 0, y: offset))
                    } else if(td.name!.starts(with: "left-edge"))
                    {
                        wall.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: td.size.width/2, height: td.size.height),
                                                         center: CGPoint(x: offset, y: 0))
                    } else if(td.name!.starts(with: "right-edge"))
                    {
                        wall.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: td.size.width/2, height: td.size.height),
                                                         center: CGPoint(x: -1*offset, y: 0))
                    } else if(td.name!.starts(with: "upper-left-edge"))
                    {
                        wall.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: td.size.width/2, height: td.size.height/2),
                                                         center: CGPoint(x: offset, y: -1*offset))
                    } else if(td.name!.starts(with: "upper-right-edge"))
                    {
                        wall.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: td.size.width/2, height: td.size.height/2),
                                                         center: CGPoint(x: -1*offset, y: -1*offset))
                    } else if(td.name!.starts(with: "lower-right-edge"))
                    {
                        wall.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: td.size.width/2, height: td.size.height/2),
                                                         center: CGPoint(x: -1*offset, y: offset))
                    } else if(td.name!.starts(with: "lower-left-edge"))
                    {
                        wall.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: td.size.width/2, height: td.size.height/2),
                                                         center: CGPoint(x: offset, y: offset))
                    } else if(td.name!.starts(with: "upper-left-corner"))
                    {
                        wall.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: td.size.width/2, height: td.size.height/2),
                                                         center: CGPoint(x: offset, y: offset))
                        
                        cornerWall.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: td.size.width/2, height: td.size.height/2),
                                                         center: CGPoint(x: -1*offset, y: -1*offset))
                    
                        addChild(cornerWall)
                    
                    } else if(td.name!.starts(with: "upper-right-corner"))
                    {
                        wall.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: td.size.width/2, height: td.size.height/2),
                                                         center: CGPoint(x: -1*offset, y: offset))
                        
                        cornerWall.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: td.size.width/2, height: td.size.height/2),
                                                         center: CGPoint(x: offset, y: -1*offset))
                        addChild(cornerWall)
                        
                    } else if(td.name!.starts(with: "lower-right-corner"))
                    {
                        wall.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: td.size.width/2, height: td.size.height/2),
                                                         center: CGPoint(x: offset, y: offset))
                        
                        cornerWall.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: td.size.width/2, height: td.size.height/2),
                                                         center: CGPoint(x: -1*offset, y: -1*offset))
                        addChild(cornerWall)
                    } else if(td.name!.starts(with: "lower-left-corner"))
                    {
                        wall.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: td.size.width/2, height: td.size.height/2),
                                                         center: CGPoint(x: -1*offset, y: offset))
                        
                        cornerWall.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: td.size.width/2, height: td.size.height/2),
                                                         center: CGPoint(x: offset, y: -1*offset))
                        addChild(cornerWall)
                    }
                    
                    wall.physicsBody?.affectedByGravity = false
                    wall.physicsBody?.allowsRotation = false
                    wall.physicsBody?.isDynamic = false
                    
                    cornerWall.physicsBody?.affectedByGravity = false
                    cornerWall.physicsBody?.allowsRotation = false
                    cornerWall.physicsBody?.isDynamic = false
                    
                    addChild(wall)
                }
            }
        }
    }
}
