//
//  GameScene.swift
//  side-scroller
//
//  Created by russell martinez on 8/25/22.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    var backgroundA : AdjacentTileMap?
    var backgroundB : AdjacentTileMap?
    private let mapCols : Int = 25
    private let mapRows : Int = 40
    private let tileSize : Int = 32
    private var fillDensity : Int = 7
    private var offset : Int = 0
    
    private var lastUpdateTime : TimeInterval = 0
    
    override func sceneDidLoad() {

        self.lastUpdateTime = 0

        offset = (mapCols * tileSize)/2
        
        let cameraNode = SKCameraNode()
        cameraNode.position = CGPoint(x: 400, y: 400)
        self.addChild(cameraNode)
        self.camera = cameraNode
        
        backgroundA = generateBackground(imageGroup: "green",
                                         position: CGPoint(x: 0, y: 0),
                                         fillDensity: fillDensity)
        
        backgroundB = generateBackground(imageGroup: "earth",
                                         position: CGPoint(x: (backgroundA?.frame.maxX)!, y: 0),
                                         fillDensity: fillDensity)
        
    }
    
    func generateBackground(imageGroup: String, position: CGPoint, fillDensity: Int) -> AdjacentTileMap
    {
        let background = AdjacentTileMap(imagesNamed: [
        "center-\(imageGroup)",
            "down-edge-\(imageGroup)",
            "left-edge-\(imageGroup)",
            "lower-left-corner-\(imageGroup)",
            "lower-left-edge-\(imageGroup)",
            "lower-right-corner-\(imageGroup)",
            "lower-right-edge-\(imageGroup)",
            "right-edge-\(imageGroup)",
            "up-edge-\(imageGroup)",
            "upper-left-corner-\(imageGroup)",
            "upper-left-edge-\(imageGroup)",
            "upper-right-corner-\(imageGroup)",
            "upper-right-edge-\(imageGroup)"
        ], columns: mapCols, rows: mapRows, tileSize: CGSize(width: tileSize, height: tileSize))
        background.anchorPoint = CGPoint(x: 0, y: 0)
        background.fill(withDensity: fillDensity)
        background.position = position
        addChild(background)
        return background
    }
    
    func touchDown(atPoint pos : CGPoint) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        camera?.position.x += 2
        
        if(backgroundA!.frame.maxX < (camera?.position.x)! - CGFloat(offset))
        {
            backgroundA?.removeFromParent()
            
            let offscreenX = Int((backgroundB?.position.x)!) + (mapCols * tileSize)
            
            backgroundA = generateBackground(imageGroup: "green",
                                             position: CGPoint(x: offscreenX, y: 0),
                                             fillDensity: fillDensity)
        }

        if(backgroundB!.frame.maxX < (camera?.position.x)! - CGFloat(offset))
        {
            backgroundB?.removeFromParent()
            
            let offscreenX = Int((backgroundA?.position.x)!) + (mapCols * tileSize)
        
            backgroundB = generateBackground(imageGroup: "earth",
                                             position: CGPoint(x: offscreenX, y: 0),
                                             fillDensity: fillDensity)
        
        }
        

        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
    }
}
