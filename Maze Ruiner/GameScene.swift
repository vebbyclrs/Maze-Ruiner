//
//  GameScene.swift
//  Maze Ruiner
//
//  Created by Vebby Clarissa on 20/05/19.
//  Copyright © 2019 Vebby Clarissa. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion

struct PhysicsCategory {
    static let none      : UInt32 = 0
    static let all       : UInt32 = UInt32.max
    static let ball      : UInt32 = 0b1
    static let endNode   : UInt32 = 0b10
    static let thorn     : UInt32 = 0b11
    static let wall      : UInt32 = 0b100
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let manager = CMMotionManager()
    var player = SKSpriteNode()
    var endNode = SKSpriteNode()
    var col: Int = 1
    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        
        player = self.childNode(withName: "player") as! SKSpriteNode
        player.texture = SKTexture(image: UIImage(named: "Ball")!)
        endNode = self.childNode(withName: "endNode") as! SKSpriteNode
        
        manager.startAccelerometerUpdates()
        manager.accelerometerUpdateInterval = 0.1
        manager.startAccelerometerUpdates(to: OperationQueue.main){
            (Data, error) in
            self.physicsWorld.gravity = CGVector(dx: CGFloat((Data?.acceleration.x)!) * 3, dy: CGFloat((Data?.acceleration.y)!) * 3)
        }
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyA : SKPhysicsBody
        let bodyB : SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            bodyA = contact.bodyA
            bodyB = contact.bodyB
        }
        else {
            bodyA = contact.bodyB
            bodyB = contact.bodyA
        }
        
        if bodyA.categoryBitMask == 1 && bodyB.categoryBitMask == 2 {//ball and flag
            
        }
        if bodyA.categoryBitMask == 1 && bodyB.categoryBitMask == 4 {
            
        }
        
    }
    
    func ballTouchFlag () {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
