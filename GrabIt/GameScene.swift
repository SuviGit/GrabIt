//
//  GameScene.swift
//  GrabIt
//
//  Created by Suvidha Nakhawa on 2/4/22.
//

import Foundation
import SpriteKit
import GameKit

class GameScene: SKScene {
    

    var floor: SKSpriteNode?
    var player: SKSpriteNode?
    var plate: SKSpriteNode?
    
    var container: SKSpriteNode?
    
    var isMoved: Bool = false
    
    var nodeName: String?

    
    var screenBounds = UIScreen.main.bounds
    
     
   // var fallingObject : SKShapeNode?
    
   
    override func sceneDidLoad() {

        createContainers()

        physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        // Create sprites

        floor = SKSpriteNode(texture: nil, color: .brown, size: CGSize(width: screenBounds.width, height: 50))
        floor?.position = CGPoint(x: screenBounds.width/2, y: 0.0)
        floor?.scene?.scaleMode = .aspectFit
        addChild(floor!)

        player = SKSpriteNode(texture: nil, color: .magenta, size: CGSize(width: 50, height: 180))
        player?.position = CGPoint(x: screenBounds.width/2, y: 120)
        player?.scene?.scaleMode = .aspectFit
        addChild(player!)


        plate = SKSpriteNode(texture: nil, color: .black, size: CGSize(width: 230, height: 40))
        plate?.position = CGPoint(x: screenBounds.width/2, y: 235)
        plate?.scene?.scaleMode = .aspectFit
        addChild(plate!)



        // Create physic bodies to the sprites

        floor?.physicsBody = SKPhysicsBody.init(rectangleOf: CGSize(width: (floor?.size.width)!, height: (floor?.size.height)!))
        
        floor?.physicsBody?.affectedByGravity = false
        floor?.physicsBody?.isDynamic = false


        player?.physicsBody = SKPhysicsBody.init(rectangleOf: CGSize(width: (player?.size.width)!, height: (player?.size.height)!))
       
        player?.physicsBody?.isDynamic = false


        plate?.physicsBody = SKPhysicsBody.init(rectangleOf: CGSize(width: (plate?.size.width)!, height: (plate?.size.height)!))
        plate?.physicsBody?.pinned = true
        plate?.physicsBody?.mass = 10.0
        plate?.physicsBody?.isDynamic = true



        createJoints()
    }
    
    
    func createJoints(){
        
        // Fixed joint for the floor
        
        let fixedJoint = SKPhysicsJointFixed.joint(withBodyA: self.physicsBody!,
                                                   bodyB: (self.floor?.physicsBody)!,
                                                   anchor: CGPoint( x: 0.0, y: (floor?.size.height)!))
        
        self.physicsWorld.add(fixedJoint)
        
        
        //Fixed joint for the player
        
        
        let playerFixedJoint = SKPhysicsJointFixed.joint(withBodyA: (self.floor?.physicsBody)!,
                                                   bodyB: (self.player?.physicsBody)!,
                                                         anchor: CGPoint( x: (self.player?.position.x)!, y: (self.player?.position.y)!))
        
        self.physicsWorld.add(playerFixedJoint)
        
        
        //Pin joint for the plate

        let platePinJoint = SKPhysicsJointPin.joint(withBodyA: (self.player?.physicsBody)!,
                                                   bodyB: (self.plate?.physicsBody)!,
                                                    anchor: CGPoint(x: (self.plate?.position.x)! + 2.5,
                                                                    y: (self.plate?.position.y)!))

        self.physicsWorld.add(platePinJoint)
        
        
    }
    
    
    func createContainers() {
        
        for i in 0..<10 {
        container = SKSpriteNode.init(imageNamed: "squareContainer")
            container?.size = CGSize(width: 200, height: 200)
        container?.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        container?.position = CGPoint(x: CGFloat(i)*(container?.size.width)!, y: screenBounds.height - (container?.size.height)!)
            container?.zPosition = -1
        container?.name = "Container"
            
        addItemsInContainer(currentContainer: container!, numberOfItems: 5, addInContainer: true, itemPosition: nil)
        
        addChild(container!)
        }
    }
    
    func addItemsInContainer(currentContainer: SKSpriteNode?, numberOfItems: Int, addInContainer:Bool, itemPosition:CGPoint?){
        
                
        for i in 0..<numberOfItems{
            let item = SKSpriteNode.init(imageNamed: "apple")
            item.size = CGSize(width: 30, height: 30)
            item.zPosition = 1
            item.name = "\("apple") \(i)"
            
            if(addInContainer){
                
                item.position = CGPoint(x: CGFloat(i)*(item.size.width) + 30, y: 100)
                
                let _container = currentContainer
                _container!.addChild(item)
            }else{
                
                item.position = itemPosition!
                
                addChild(item)
            }
           
        }
    }
    
    
    
    func scrollContainers(currentLocation:CGPoint){
          
        let pos = currentLocation
        
        self.enumerateChildNodes(withName: "Container", using: ({
            (node, error)in
            //node.position.x -= 10
            node.run(SKAction.moveBy(x: pos.x, y: 0.0, duration: 0.25))
            
            
        }))
        
    }
    
    
    
    override func didMove(to view: SKView) {
       
       // self.anchorPoint = CGPoint(x: 0.0, y: 0.0)
            let swipeDirections:[UISwipeGestureRecognizer.Direction] = [.right, .left]
            
            for swipeDirection in swipeDirections{
                let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.swiped(sender:)))
                swipeRecognizer.direction = swipeDirection
                view.addGestureRecognizer(swipeRecognizer)
            }
  
            
    }
    
    @objc func swiped(sender: UISwipeGestureRecognizer){
       // print("swipe detected", sender.direction)
        if(isMoved){
            isMoved = false
            
            var pos:CGPoint
            
            if(sender.direction == .left){
                
                pos = CGPoint(x: -200, y: 0.0)
                scrollContainers(currentLocation: pos)
                
            }else if(sender.direction == .right){
             
                pos = CGPoint(x: 200, y: 0.0)
                scrollContainers(currentLocation: pos)
            }
            
        }
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else{return}

        let location = touch.location(in: self)
        let node: SKNode = self.atPoint(location)
        
       // print("node touch began  ",node.name as Any)
       
        if(node.name != "Container" && node.name != "" && node.name != nil){
            node.removeFromParent()
            addItemsInContainer(currentContainer: nil, numberOfItems: 1, addInContainer: false, itemPosition: location)
            
        }
        else if(node.name == "Container"){
           
            isMoved = true
        }

        //dragSpriteNode(location: location)
//
//        let box = SKSpriteNode(texture: nil, color: .red, size: CGSize(width: 30, height: 30))
//        box.position = location
//        box.physicsBody?.mass = 1.2
//        box.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 30, height: 30))
//        addChild(box)

    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else{return}

        let location = touch.location(in: self)
        let node:SKNode = self.atPoint(location)

        //print("TOUCH ENDED..... ",node.name as Any)

        if(nodeName == node.name && nodeName != "" && node.name != nil){
                node.name = ""

                node.physicsBody = SKPhysicsBody.init(rectangleOf: CGSize(width: 30, height: 30))
                node.physicsBody?.mass = 1.0
               
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

        guard let touch = touches.first else{return}

        let location = touch.location(in: self)
        let prevLocation = touch.previousLocation(in: self)
        
        let node:SKNode = self.atPoint(location)

        if(node.name != "Container" && node.name != "" && node.name != nil){
            dragSpriteNode(location: location, prevlocation: prevLocation)
        }
        

    }
    
    
    func dragSpriteNode(location: CGPoint, prevlocation:CGPoint){
        
        let node:SKNode = self.atPoint(location)

        
        if( node.name != "Container"){
    
            
            nodeName = node.name
            
            let diffX:CGFloat = location.x - prevlocation.x
            let diffY:CGFloat = location.y - prevlocation.y
            
            let newLocation:CGPoint = CGPoint(x: node.position.x + diffX , y: node.position.y + diffY)

            node.position = newLocation
            
            
           
            
        }
        
    }
    
}

