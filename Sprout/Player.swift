//
//  Player.swift
//  Sprout
//
//  Created by Matthew Curtner on 8/27/17.
//  Copyright © 2017 Matthew Curtner. All rights reserved.
//

import SpriteKit

extension GameScene {
    
    /// Setup the player spritenode texture, physicsbody, and position
    func createPlayer() {
        // Setup the plant texture
        let plantTexture = SKTexture(imageNamed: "plant")
        
        // Setup player spritenode
        player = SKSpriteNode(texture: plantTexture)
        player.position = CGPoint(x: self.size.width/2, y: ground.position.y + 200)
        player.name = "player"
        player.anchorPoint = CGPoint(x: 0.5, y: 0.3)
        
        // Physics
        player.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: player.size.width/2, height: player.size.height/3) , center: player.anchorPoint)
        player.physicsBody?.isDynamic = true
        player.physicsBody?.linearDamping = 0
        player.physicsBody?.categoryBitMask = playerCategory
        player.physicsBody?.collisionBitMask = groundCategory | sidesCategory
        player.physicsBody?.contactTestBitMask = groundCategory | enemyCategory | dropCategory

        self.addChild(player)
    }
    
    
    /// Moves the player sprite either to the left or right
    /// based on the buttons touched.  Does not allow double
    /// jumping.
    ///
    /// - Parameter right: Check if right button was pressed,
    /// otherwise executes the left button
    func movePlayerHorizonatally(right: Bool) {
        if ableToJump == true {
            ableToJump = false
            if right {
                let moveRight = SKAction.moveBy(x: 30, y: 50, duration: 0.1)
                player?.run(moveRight)
            }else{
                let moveLeft = SKAction.moveBy(x: -30, y: 50, duration: 0.1)
                player?.run(moveLeft)
            }
        }
    }
}
