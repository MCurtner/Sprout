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
    
    var player: SKSpriteNode!
    var ground: SKSpriteNode!
    
    var ableToJump = true
    
    // MARK: Collision Categories
    let playerCategory:UInt32 = 0x1 << 0
    let groundCategory:UInt32 = 0x1 << 1
    let enemyCategory:UInt32 = 0x1 << 2
    let dropCategory:UInt32 = 0x1 << 3
    let sidesCategory: UInt32 = 0x1 << 4
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        createBounds()
        createGround()
        createPlayer()
        createDrop(type: .small)
    }
    
    override func update(_ currentTime: TimeInterval) {
    }
    
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
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            playerBody = contact.bodyA
            otherBody = contact.bodyB
        } else {
            playerBody = contact.bodyB
            otherBody = contact.bodyA
        }
        
        if playerBody.categoryBitMask == playerCategory && otherBody.categoryBitMask == groundCategory {
            ableToJump = true
        }
    }
    
    func createBounds() {
        let boundry = SKPhysicsBody(edgeLoopFrom: self.frame)
        boundry.categoryBitMask = sidesCategory
        self.physicsBody = boundry
    }
    
    func createGround() {
        ground = SKSpriteNode(color: .brown, size: CGSize(width: self.size.width + 10, height: 15.0))
        ground.position = (self.childNode(withName: "ground")?.position)!
        ground.physicsBody = SKPhysicsBody(rectangleOf: ground.size, center: CGPoint.zero)
        ground.physicsBody?.categoryBitMask = groundCategory
        ground.physicsBody?.contactTestBitMask = playerCategory
        ground.physicsBody?.isDynamic = false
        self.addChild(ground)
    }
 
}
