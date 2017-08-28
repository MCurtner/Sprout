//
//  Drops.swift
//  Sprout
//
//  Created by Matthew Curtner on 8/27/17.
//  Copyright © 2017 Matthew Curtner. All rights reserved.
//

import SpriteKit

enum Waterdrop: Int {
    case small
    case medium
    case large
}

extension GameScene {
    
    func createDrop(type: Waterdrop) {
        let drop = SKSpriteNode(imageNamed: "drop")
        drop.name = "waterdrop"
        
        switch type {
        case .small:
            drop.setScale(0.5)
        case .medium:
            drop.setScale(1.0)
        case .large:
            drop.setScale(2.0)
        }
        
        drop.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        drop.anchorPoint = CGPoint(x: 0.5, y: 0.33)
        
        drop.physicsBody = SKPhysicsBody(circleOfRadius: drop.size.height/4)
        drop.physicsBody = SKPhysicsBody(circleOfRadius: drop.size.height/4, center: drop.anchorPoint)
        
        drop.physicsBody?.isDynamic = false
        
        self.addChild(drop)
    }
}
