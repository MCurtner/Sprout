//
//  GameScene.swift
//  Sprout
//
//  Created by Matthew Curtner on 8/27/17.
//  Copyright © 2017 Matthew Curtner. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    // MARK: - Variables
    var player: SKSpriteNode!
    var ground: SKSpriteNode!
    var drop: SKSpriteNode!
    var cloud: SKSpriteNode!
    
    var ableToJump = true
    
    var points: Int = 0
    
    // MARK: Bitmask Categories
    let playerCategory: UInt32 = 0x1 << 0
    let groundCategory: UInt32 = 0x1 << 1
    let enemyCategory: UInt32 = 0x1 << 2
    let dropCategory: UInt32 = 0x1 << 3
    let sidesCategory: UInt32 = 0x1 << 4
    
    // MARK: - Load view
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        
        // Create Game World
        createBounds()
        createGround()
        createCloud()
        createPlayer()
        createDrop()
    }
    
    // MARK: - Update
    override func update(_ currentTime: TimeInterval) {
    }
    
    /// MARK: Touches
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.previousLocation(in: self)
            let node = self.nodes(at: location).first
            
            if node?.name == "right" {
               movePlayerHorizonatally(right: true)
            } else if node?.name == "left" {
                movePlayerHorizonatally(right: false)
            }
        }
    }
    
    // MARK: - Contact Delegate
    
    func didBegin(_ contact: SKPhysicsContact) {
        var playerBody:SKPhysicsBody
        var otherBody:SKPhysicsBody
        
        // Get the correct player bitmask
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            playerBody = contact.bodyA
            otherBody = contact.bodyB
        } else {
            playerBody = contact.bodyB
            otherBody = contact.bodyA
        }
        
        // If player is touching ground, set ableToJump to true
        if playerBody.categoryBitMask == playerCategory && otherBody.categoryBitMask == groundCategory {
            ableToJump = true
        }
        
        if playerBody.categoryBitMask == playerCategory && otherBody.categoryBitMask == dropCategory {
            points += 1
            removeDrop()
        }
        
        if playerBody.categoryBitMask == groundCategory && otherBody.categoryBitMask == dropCategory {
            removeDrop()
        }
    }
    
    // MARK: - Setup
    
    /// Create the screen bounds to prevent the player from falling off screen
    func createBounds() {
        let boundry = SKPhysicsBody(edgeLoopFrom: self.frame)
        boundry.categoryBitMask = sidesCategory
        self.physicsBody = boundry
    }
    
    /// Setup the ground SKSpriteNode with physicsbody values
    func createGround() {
        ground = SKSpriteNode(color: .brown, size: CGSize(width: self.size.width + 10, height: 15.0))
        ground.position = (self.childNode(withName: "ground")?.position)!
        ground.physicsBody = SKPhysicsBody(rectangleOf: ground.size, center: CGPoint.zero)
        ground.physicsBody?.categoryBitMask = groundCategory
        ground.physicsBody?.contactTestBitMask = playerCategory
        ground.physicsBody?.isDynamic = false
        self.addChild(ground)
    }
    
    /// Create the Cloud Sprite
    func createCloud() {
        cloud = SKSpriteNode(imageNamed: "cloud")
        cloud.position = CGPoint(x: 0, y: self.size.height - 20)
        cloud.setScale(1.0)
        cloud.zPosition = 2
        self.addChild(cloud)
        
        // Animate the cloud's movement
        animateCloud()
    }
    
    /// Animate the cloud's movement from right to left
    func animateCloud() {
        let moveRight = SKAction.moveBy(x: self.size.width, y: 0, duration: 5)
        let moveLeft = SKAction.moveBy(x: -self.size.width, y: 0, duration: 5)
        let repeatAction = SKAction.repeatForever(SKAction.sequence([moveRight, moveLeft]))
        cloud.run(repeatAction)
    }
}
