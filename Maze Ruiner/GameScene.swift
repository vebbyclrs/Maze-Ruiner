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
    static let ball      : UInt32 = 0b01
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
        print ("self:\(self)")
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
            ballTouchedFlag()
        } else if bodyA.categoryBitMask == 1 && bodyB.categoryBitMask == 3{ //ball and spikes
            ballTouchedSpikes()
        }
    }
    
    func ballTouchedSpikes () {
        print ("you lose")
        childNode(withName: "player")?.physicsBody?.affectedByGravity = false
        childNode(withName: "player")?.physicsBody?.isDynamic = false
        let popUpMessage = SKSpriteNode(color: UIColor.black, size: CGSize(width: 330, height: 200))
        popUpMessage.name = "popUpMessage"
        popUpMessage.alpha = 0.8
        popUpMessage.drawBorder(color: UIColor.red, width: 3)
        popUpMessage.position = CGPoint(x: self.size.width * 0.5, y: -(self.size.height * 0.5)) ;popUpMessage.zPosition = CGFloat(1)
        addChild(popUpMessage)
        
        let buttonTexture = SKTexture(imageNamed: "ButtonReplay")
        let buttonPressedTexture = SKTexture(imageNamed: "ButtonReplay On Klick")
        let replayButton = FTButtonNode(normalTexture: buttonTexture, selectedTexture: buttonPressedTexture, disabledTexture: buttonTexture)
        replayButton.position = popUpMessage.position ; replayButton.zPosition = 2
        replayButton.name = "replayButton"
        addChild(replayButton)
        replayButton.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(replayTheGame))
    }
    @objc func replayTheGame() {
        let newScene = SKScene(fileNamed: "GameScene")
        let transition = SKTransition.fade(withDuration: 1.0)
        self.childNode(withName: "popUpMessage")?.removeFromParent()
        self.childNode(withName: "replayButton")?.removeFromParent()
        self.view?.presentScene(newScene!, transition: transition)
        
    }

    
    func resetPLayer() {
        player.position = CGPoint(x: 387, y: -864)
        player.zPosition = 0
        player.physicsBody?.isDynamic = true
        player.physicsBody?.affectedByGravity = true
    }
    
    func ballTouchedFlag() {
        print ("you won")
        childNode(withName: "player")?.physicsBody?.affectedByGravity = false
        childNode(withName: "player")?.physicsBody?.isDynamic = false
        
        let popUpMessage = SKSpriteNode(color: UIColor.white, size: CGSize(width: 330, height: 200))
        popUpMessage.name = "popUpMessage"
        popUpMessage.alpha = 0.95
        popUpMessage.drawBorder(color: UIColor.red, width: 3)
        popUpMessage.position = CGPoint(x: self.size.width * 0.5, y: -(self.size.height * 0.5))
        popUpMessage.zPosition = CGFloat(1)
        addChild(popUpMessage)
        
        let trophy = SKSpriteNode(imageNamed: "Trophy")
        trophy.zPosition = 2
        trophy.position = popUpMessage.position
        addChild(trophy)
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
