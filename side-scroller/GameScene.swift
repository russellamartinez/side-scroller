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
    
    lazy var player : SKNode? = childNode(withName: "player")
    
    var backgroundA : AdjacentTileMap?
    var backgroundB : AdjacentTileMap?
    private let mapCols : Int = 50
    private let mapRows : Int = 40
    private let tileSize : Int = 32
    private var fillDensity : Int = 7
    private var offset : Int = 0
    
    private let score : SKLabelNode = SKLabelNode(text: "0")
    
    private var lastUpdateTime : TimeInterval = 0
    
    override func sceneDidLoad() {

        self.lastUpdateTime = 0
        
        physicsWorld.contactDelegate = self

        offset = (mapCols * tileSize)/2

        backgroundA = generateBackground(imageGroup: "green",
                                         position: CGPoint(x: 0, y: 0),
                                         fillDensity: fillDensity)
        
        backgroundB = generateBackground(imageGroup: "earth",
                                         position: CGPoint(x: (backgroundA?.frame.maxX)!, y: 0),
                                         fillDensity: fillDensity)
        
        backgroundA?.generateGems()
        backgroundB?.generateGems()
        
        let cameraNode = SKCameraNode()
        cameraNode.position = CGPoint(x: (backgroundA?.frame.midX)!, y: (backgroundA?.frame.midY)!)
        self.addChild(cameraNode)
        self.camera = cameraNode
        
        player?.position = camera!.position
        player?.physicsBody = SKPhysicsBody(circleOfRadius: 8)
        player?.physicsBody?.contactTestBitMask = PhysicsCategory.wall
        player?.physicsBody?.categoryBitMask = PhysicsCategory.player
    
        score.position.x = camera!.position.x
        score.position.y = UIScreen.main.nativeBounds.maxY - 75
        addChild(score)
       
    }

    func touchDown(atPoint pos : CGPoint) {
        if(pos.x > player!.position.x && pos.y > player!.position.y)
        {
            player!.physicsBody?.velocity = CGVector(dx: 250, dy: 500)
        }else if(pos.x < player!.position.x && pos.y > player!.position.y)
        {
            player!.physicsBody?.velocity = CGVector(dx: -100, dy: 500)
        }else if(pos.x < player!.position.x && pos.y < player!.position.y)
        {
            player!.physicsBody?.velocity = CGVector(dx: -100, dy: 250)
        } else if (pos.x > player!.position.x && pos.y < player!.position.y)
        {
            player!.physicsBody?.velocity = CGVector(dx: 250, dy: 250)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
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
        background.setupPhysics()
        addChild(background)
        return background
    }
    
    func addToScore(points: Int)
    {
        var scoreModification = Int((score.text)!)
        (scoreModification)! += points
        score.text = "\(scoreModification ?? -1)"
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
        score.position.x = camera!.position.x
        
        if(backgroundA!.frame.maxX < (camera?.position.x)! - CGFloat(offset))
        {
            backgroundA?.removeFromParent()
            
            let offscreenX = Int((backgroundB?.position.x)!) + (mapCols * tileSize)
            
            backgroundA = generateBackground(imageGroup: "green",
                                             position: CGPoint(x: offscreenX, y: 0),
                                             fillDensity: fillDensity)
        
            backgroundA?.generateGems()
        }

        if(backgroundB!.frame.maxX < (camera?.position.x)! - CGFloat(offset))
        {
            backgroundB?.removeFromParent()
            
            let offscreenX = Int((backgroundA?.position.x)!) + (mapCols * tileSize)
        
            backgroundB = generateBackground(imageGroup: "earth",
                                             position: CGPoint(x: offscreenX, y: 0),
                                             fillDensity: fillDensity)
        
            backgroundB?.generateGems()
        }
        
        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
    }
}
