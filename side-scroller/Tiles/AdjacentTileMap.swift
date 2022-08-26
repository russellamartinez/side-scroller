//
//  AdjacentTileMap.swift
//  side-scroller
//
//  Created by russell martinez on 8/25/22.
//

import SpriteKit

import SpriteKit

class AdjacentTileMap : SKTileMapNode {

    public var TileGroup : SKTileGroup?
    
    init(imagesNamed : [String], columns : Int, rows : Int, tileSize : CGSize)
    {
        var rules : [SKTileGroupRule] = []
        
        for imageNamed in imagesNamed {
            let definition = SKTileDefinition(texture: SKTexture(imageNamed: imageNamed))
            definition.name = imageNamed
            
            if(imageNamed.starts(with: "upper-left-edge"))
            {
                let rule = SKTileGroupRule(adjacency: .adjacencyUpperLeftEdge, tileDefinitions: [definition])
                rules.append(rule)
            }else if(imageNamed.starts(with: "up-edge"))
            {
                let rule = SKTileGroupRule(adjacency: .adjacencyUpEdge, tileDefinitions: [definition])
                rules.append(rule)
            }else if(imageNamed.starts(with: "upper-right-edge"))
            {
                let rule = SKTileGroupRule(adjacency: .adjacencyUpperRightEdge, tileDefinitions: [definition])
                rules.append(rule)
            }else if(imageNamed.starts(with: "left-edge"))
            {
                let rule = SKTileGroupRule(adjacency: .adjacencyLeftEdge, tileDefinitions: [definition])
                rules.append(rule)
            }else if(imageNamed.starts(with: "center"))
            {
                let rule = SKTileGroupRule(adjacency: .adjacencyAll, tileDefinitions: [definition])
                rules.append(rule)
            }else if(imageNamed.starts(with: "right-edge"))
            {
                let rule = SKTileGroupRule(adjacency: .adjacencyRightEdge, tileDefinitions: [definition])
                rules.append(rule)
            }else if(imageNamed.starts(with: "lower-left-edge"))
            {
                let rule = SKTileGroupRule(adjacency: .adjacencyLowerLeftEdge, tileDefinitions: [definition])
                rules.append(rule)
            }else if(imageNamed.starts(with: "down-edge"))
            {
                let rule = SKTileGroupRule(adjacency: .adjacencyDownEdge, tileDefinitions: [definition])
                rules.append(rule)
            }else if(imageNamed.starts(with: "lower-right-edge"))
            {
                let rule = SKTileGroupRule(adjacency: .adjacencyLowerRightEdge, tileDefinitions: [definition])
                rules.append(rule)
            }else if(imageNamed.starts(with: "upper-left-corner"))
            {
                let rule = SKTileGroupRule(adjacency: .adjacencyUpperLeftCorner, tileDefinitions: [definition])
                rules.append(rule)
            }else if(imageNamed.starts(with: "upper-right-corner"))
            {
                let rule = SKTileGroupRule(adjacency: .adjacencyUpperRightCorner, tileDefinitions: [definition])
                rules.append(rule)
            }else if(imageNamed.starts(with: "lower-right-corner"))
            {
                let rule = SKTileGroupRule(adjacency: .adjacencyLowerRightCorner, tileDefinitions: [definition])
                rules.append(rule)
            }else if(imageNamed.starts(with: "lower-left-corner"))
            {
                let rule = SKTileGroupRule(adjacency: .adjacencyLowerLeftCorner, tileDefinitions: [definition])
                rules.append(rule)
            }
        }
        
        
        self.TileGroup = SKTileGroup(rules: rules)
        
        super.init(tileSet: SKTileSet(tileGroups: [TileGroup!]),
                   columns: columns,
                   rows: rows,
                   tileSize: tileSize)
    }
    
    func fill(withDensity density: Int){
        self.enableAutomapping = true
        
        for col in 0..<numberOfColumns {
            for row in 0..<numberOfRows {
                if(row.isMultiple(of: density)) {
                    if(col.isMultiple(of: density)) {
                        setTileGroup(TileGroup, forColumn: Int.random(in: 0...47), row: Int.random(in: 0...47))
                    }
                }
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
