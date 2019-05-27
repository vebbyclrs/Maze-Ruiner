//
//  GameOverScene.swift
//  Maze Ruiner
//
//  Created by Vebby Clarissa on 24/05/19.
//  Copyright © 2019 Vebby Clarissa. All rights reserved.
//

import UIKit
import SpriteKit

class GameOverScene: SKScene {
    init (size: CGSize , won: Bool) {
        super.init(size:size)
        alpha = 1.0
//        let popUpWindow = childNode(withName: "message") as! SKSpriteNode
        let popUpWindow = SKSpriteNode(color: UIColor.red, size: CGSize(width: 329, height: 202))
        popUpWindow.position = CGPoint(x: CGFloat(self.size.width*0.5), y: CGFloat(self.size.height*0.5))
        popUpWindow.alpha = 0.8
//        var button = childNode(withName:"button") as! SKSpriteNode
//        popUpWindow.size = CGSize(width: 329, height: 202)
        popUpWindow.drawBorder(color: UIColor.red, width: CGFloat(3))
        addChild(popUpWindow)
        
        if won {
            let button = childNode(withName:"button") as! SKSpriteNode
            popUpWindow.color = UIColor(red: 255, green: 255, blue: 255, alpha: 0.9)
            button.texture = SKTexture(imageNamed: "Trophy")
            
        }
        
        else {
            childNode(withName: "button")?.isHidden = true
            popUpWindow.color = UIColor(red:    255.0, green: 255.0, blue: 255.0, alpha: 0.1)
            let button = FTButtonNode(normalTexture: SKTexture(imageNamed: "Replay"), selectedTexture: SKTexture(imageNamed: "Replay"), disabledTexture: nil)
            button.position = CGPoint (x: CGFloat(207), y: CGFloat( -448))
            button.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(replayButtonTapped))
            addChild(button)
            
            
        }
    }
    
    @objc func replayButtonTapped() {
        print ("Replay tapped")
        
        let transition = SKTransition.fade(withDuration: 0.3)
        let nextScene = GameScene(size: self.size)
        
        self.view?.presentScene(nextScene, transition: transition)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SKSpriteNode {
    func drawBorder(color: UIColor, width: CGFloat) {
        let shapeNode = SKShapeNode(rect: frame)
        shapeNode.fillColor = .clear
        shapeNode.strokeColor = color
        shapeNode.lineWidth = width
        addChild(shapeNode)
    }
}
