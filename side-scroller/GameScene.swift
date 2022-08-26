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
    private let mapCols : Int = Int(25)
    private let mapRows : Int = Int(40)
    private let tileSize : Int = Int(32)
    private var fillDensity : Int = Int(25)
    
    private var lastUpdateTime : TimeInterval = 0
    
    override func sceneDidLoad() {

        self.lastUpdateTime = 0

        let cameraNode = SKCameraNode()
        cameraNode.position = CGPoint(x: 400, y: 400)
        self.addChild(cameraNode)
        self.camera = cameraNode
        
        backgroundA = createTileMap(imageGroup: "green")
        backgroundA?.anchorPoint = CGPoint(x: 0, y: 0)
        backgroundB = createTileMap(imageGroup: "earth")
        backgroundB?.anchorPoint = CGPoint(x: 0, y: 0)
        
        generateBackground(background: backgroundA!,
                           position: CGPoint(x: 0, y: 0),
                           fillDensity: fillDensity)
        
        let offscreenX = Int((backgroundA?.frame.maxX)!)
    
        generateBackground(background: backgroundB!,
                           position: CGPoint(x: offscreenX, y: 0),
                           fillDensity: fillDensity)
        
    }
    
    func createTileMap(imageGroup: String) -> AdjacentTileMap
    {
        return AdjacentTileMap(imagesNamed: [
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
    }
    
    func generateBackground(background: AdjacentTileMap, position: CGPoint, fillDensity: Int)
    {
        background.fill(withDensity: 1)
        background.position = position
        addChild(background)
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
        
        let offset = (mapCols * tileSize)/2
        
        if(backgroundA!.frame.maxX < (camera?.position.x)! - CGFloat(offset))
        {
            backgroundA?.removeFromParent()
            
            let offscreenX = Int((backgroundB?.position.x)!) + (mapCols * tileSize)
            backgroundA = createTileMap(imageGroup: "green")
            backgroundA?.anchorPoint = CGPoint(x: 0, y: 0)
            generateBackground(background: backgroundA!
                               , position: CGPoint(x: offscreenX
                                , y: 0), fillDensity: fillDensity)
        }

        if(backgroundB!.frame.maxX < (camera?.position.x)! - CGFloat(offset))
        {
            backgroundB?.removeFromParent()
            
            let offscreenX = Int((backgroundA?.position.x)!) + (mapCols * tileSize)
            backgroundB = createTileMap(imageGroup: "earth")
            backgroundB?.anchorPoint = CGPoint(x: 0, y: 0)
            generateBackground(background: backgroundB!
                               , position: CGPoint(x: offscreenX
                                , y: 0), fillDensity: fillDensity)
        }
        

        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
    }
}
