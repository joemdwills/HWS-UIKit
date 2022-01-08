//
//  GameScene.swift
//  Day66
//
//  Created by Joe Williams on 08/11/2021.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {

//    var rain: SKEmitterNode!
    var reloadLabel: SKLabelNode!
    var ammoLabel: SKLabelNode!
    var scorelabel: SKLabelNode!
    var ammo = 6 {
        didSet {
            ammoLabel.text = "x\(ammo)"
        }
    }
    var score = 0 {
        didSet {
            scorelabel.text = "Score: \(score)"
        }
    }
    var bullet: SKSpriteNode!
    var targets = ["smallTarget", "bigTarget", "badTarget"]
    var yPosition = [640, 400, 160]
    var xPosition = [-100, 1124, -100]
    var timeInterval = 1.0
    var secondsRemaining = 60 {
        didSet {
            timeLabel.text = "Time Remaining: \(secondsRemaining)"
        }
    }
    var timeLabel: SKLabelNode!
    var gameTimer: Timer?

    override func didMove(to view: SKView) {
        backgroundColor = .blue
//        rain = SKEmitterNode(fileNamed: "Rain")
//        rain.position = CGPoint(x: 512, y: 900)
//        rain.advanceSimulationTime(5)
//        rain.zPosition = -1
//        addChild(rain)
    
        reloadLabel = SKLabelNode(fontNamed: "Menlo-BoldItalic")
        reloadLabel.text = "Reload"
        reloadLabel.fontSize = 24
        reloadLabel.fontColor = .white
        reloadLabel.horizontalAlignmentMode = .center
        reloadLabel.position = CGPoint(x: 512, y: 20)
        addChild(reloadLabel)
        
        ammoLabel = SKLabelNode(fontNamed: "Menlo-Bold")
        ammoLabel.text = "x\(ammo)"
        ammoLabel.fontSize = 32
        ammoLabel.fontColor = .white
        ammoLabel.horizontalAlignmentMode = .left
        ammoLabel.position = CGPoint(x: 60, y: 25)
        addChild(ammoLabel)
        
        bullet = SKSpriteNode(imageNamed: "bullet")
        bullet.position = CGPoint(x: 20, y: 20)
        bullet.size = CGSize(width: 30, height: 50)
        bullet.anchorPoint = CGPoint(x: 0, y: 0)
        addChild(bullet)
        
        scorelabel = SKLabelNode(fontNamed: "Menlo-BoldItalic")
        scorelabel.text = "Score: \(score)"
        scorelabel.fontSize = 24
        scorelabel.fontColor = .white
        scorelabel.horizontalAlignmentMode = .center
        scorelabel.position = CGPoint(x: 512, y: 740)
        addChild(scorelabel)
        
        timeLabel = SKLabelNode(fontNamed: "Menlo-BoldItalic")
        timeLabel.text = "Time Remaining: \(secondsRemaining)"
        timeLabel.fontSize = 24
        timeLabel.fontColor = .white
        timeLabel.horizontalAlignmentMode = .right
        timeLabel.position = CGPoint(x: 1004, y: 740)
        addChild(timeLabel)
        
        physicsWorld.gravity = .zero
        gameTimer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(createTarget), userInfo: nil, repeats: true)
    }
//    Old Version
//    @objc func createTarget() {
//        guard let target = targets.randomElement() else {return}
//        let element = Int.random(in: 0...2)
//        var xVelocity = 200
//
//        if target == "smallTarget" {
//            xVelocity = 600
//        }
//        if element == 1 {
//            xVelocity = -xVelocity
//        }
//
//        let sprite = SKSpriteNode(imageNamed: target)
//        sprite.position = CGPoint(x: xPosition[element], y: yPosition[element])
//        addChild(sprite)
//        sprite.name = target
//        sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
//        sprite.physicsBody?.categoryBitMask = 1
//        sprite.physicsBody?.velocity = CGVector(dx: xVelocity, dy: 0)
//        sprite.physicsBody?.linearDamping = 0
//        sprite.physicsBody?.angularDamping = 0
//    }
    
//    moveBy() version
    @objc func createTarget() {
        if secondsRemaining > 1 {
            secondsRemaining -= Int(timeInterval)
        } else {
            secondsRemaining -= Int(timeInterval)
            gameTimer?.invalidate()
            let gameOver = SKSpriteNode(imageNamed: "gameOver")
            gameOver.position = CGPoint(x: 512, y: 384)
            gameOver.zPosition = 1
            addChild(gameOver)
            
        }
        
        guard let target = targets.randomElement() else {return}
        let element = Int.random(in: 0...2)
        var delay = SKAction.wait(forDuration: 0.0)
        var moveDuration = 3.0
        var xDistance: CGFloat = 1200

        if target == "smallTarget" {
            delay = SKAction.wait(forDuration: 0.5)
            moveDuration = 2.0
        }
        if element == 1 {
            xDistance = -xDistance
        }
        
        let sprite = SKSpriteNode(imageNamed: target)
        sprite.position = CGPoint(x: xPosition[element], y: yPosition[element])
        sprite.name = target
        let deleteTarget = SKAction.run {
            sprite.removeFromParent()
        }
        let travel = SKAction.moveBy(x: xDistance, y: 0, duration: moveDuration)
        let sequence = SKAction.sequence([delay, travel, deleteTarget])
        addChild(sprite)
        sprite.run(sequence)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        let location = touch.location(in: self)
        let tappedNodes = nodes(at: location)
        
        if tappedNodes.contains(reloadLabel) {
            ammo = 6
        } else if ammo >= 1 {
            ammo -= 1
            for node in tappedNodes {
                if node.name == "bigTarget" {
                    score += 1
                    hitTarget(node: node)
                    return
                } else if node.name == "smallTarget" {
                    score += 3
                    hitTarget(node: node)
                    return
                } else if node.name == "badTarget" {
                    score -= 1
                    hitTarget(node: node)
                    return
                }
            }
            score -= 1
        }
    }
    
    func hitTarget(node: SKNode) {
        if let explosionEffect = SKEmitterNode(fileNamed: "explosion") {
            let end = SKAction.wait(forDuration: 0.5)
            let delete = SKAction.run {
                explosionEffect.removeFromParent()
            }
            let sequence = SKAction.sequence([end, delete])
            explosionEffect.position = node.position
            node.removeFromParent()
            addChild(explosionEffect)
            explosionEffect.run(sequence)
        }
    }
    
//    override func update(_ currentTime: TimeInterval) {
//        // Called before each frame is rendered
//        for node in children {
//            if node.position.x < -200 {
//                node.removeFromParent()
//            } else if node.position.x > 1400 {
//                node.removeFromParent()
//            }
//        }
//
//    }
}
