//
//  GameScene.swift
//  GrabIt
//
//  Created by Suvidha Nakhawa on 2/4/22.
//

import Foundation
import SpriteKit
import GameKit

class GameScene: SKScene{
    
    var floor: SKSpriteNode?
    var player: SKSpriteNode?
    var plate: SKSpriteNode?
    
    override func sceneDidLoad() {

        physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        floor = SKSpriteNode(texture: nil, color: .brown, size: CGSize(width: 1.0, height: 0.175))
        floor?.position = CGPoint(x: 0.5, y: 0.0)
        addChild(floor!)
        
        player = SKSpriteNode(texture: nil, color: .magenta, size: CGSize(width: 0.15, height: 0.4))
        player?.position = CGPoint(x: 0.5, y: 0.275)
        addChild(player!)
        
        
        plate = SKSpriteNode(texture: nil, color: .black, size: CGSize(width: 0.75, height: 0.06))
        plate?.position = CGPoint(x: 0.5, y: (player?.size.height)! + 0.06)
        addChild(plate!)
        
    }
    
    
}

