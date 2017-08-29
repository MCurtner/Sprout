//
//  Drops.swift
//  Sprout
//
//  Created by Matthew Curtner on 8/27/17.
//  Copyright © 2017 Matthew Curtner. All rights reserved.
//

import SpriteKit

extension GameScene {
    
    /// Creates the correct water drop sprite and physicsbody
    /// based on the passed in water type.
    ///
    /// - Parameter type: Waterdrop type
    func createDrop() {
        drop = SKSpriteNode(imageNamed: "drop")
        drop.name = "waterdrop"
        drop.setScale(0.5)
        
        // Set the drop position as the clouds position
        drop.position = CGPoint(x: cloud.position.x, y: cloud.position.y - 5)
        drop.anchorPoint = CGPoint(x: 0.5, y: 0.33)
        
        // Physics
        drop.physicsBody = SKPhysicsBody(circleOfRadius: drop.size.height/4)
        drop.physicsBody = SKPhysicsBody(circleOfRadius: drop.size.height/4, center: drop.anchorPoint)
        drop.physicsBody?.categoryBitMask = dropCategory
        drop.physicsBody?.contactTestBitMask = playerCategory | groundCategory
        
        self.addChild(drop)
    }
    
    /// Remove the rain drop and then create a new one
    func removeDrop() {
        drop.removeAllActions()
        drop.removeFromParent()
        createDrop()
    }
}
