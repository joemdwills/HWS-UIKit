//
//  GameScene.swift
//  Project26
//
//  Created by Joe Williams on 13/12/2021.
//


import CoreMotion
import SpriteKit

enum CollisionTypes: UInt32 {
    case player = 1
    case wall = 2
    case star = 4
    case vortex = 8
    case teleport = 16
    case finish = 32
}


class GameScene: SKScene, SKPhysicsContactDelegate {
    var player: SKSpriteNode!
    var lastTouchPosition: CGPoint?
    var motionManager: CMMotionManager?
    var scoreLabel: SKLabelNode!
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    var isGameOver = false
    var levelLabel: SKLabelNode!
    var level = 1 {
        didSet {
            levelLabel.text = "Level: \(level)"
        }
    }
    var levelNodes = [SKSpriteNode]()
    var startPosition = CGPoint(x: 96, y: 672)
    var teleportContact = false
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        
        motionManager = CMMotionManager()
        motionManager?.startAccelerometerUpdates()
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: 0"
        scoreLabel.horizontalAlignmentMode = .left
        scoreLabel.position = CGPoint(x: 16, y: 16)
        scoreLabel.zPosition = 2
        addChild(scoreLabel)
        
        levelLabel = SKLabelNode(fontNamed: "Chalkduster")
        levelLabel.text = "Level: 1"
        levelLabel.horizontalAlignmentMode = .left
        levelLabel.position = CGPoint(x: 875, y: 16)
        levelLabel.zPosition = 2
        addChild(levelLabel)
        
        loadLevel(level: level)
        createPlayer(position: startPosition)
        }
    
    func loadLevel(level: Int) {
        guard let levelURL = Bundle.main.url(forResource: "level\(level)", withExtension: "txt") else { fatalError("Could not find level\(level).txt in the app bundle.") }
        guard let levelString = try? String(contentsOf: levelURL) else { fatalError("Could not find level\(level).txt from the app bundle.") }
        let lines = levelString.components(separatedBy: "\n")
        for (row, line) in lines.reversed().enumerated() {
            for (column, letter) in line.enumerated() {
                let position = CGPoint(x: (64 * column) + 32, y: (64 * row) + 32)
                
                if letter == "x" {
                    let node = SKSpriteNode(imageNamed: "block")
                    node.name = "block"
                    addNodePhysics(node: node)
                    addNodeToView(node: node, position: position)
                } else if letter == "v" {
                    let node = SKSpriteNode(imageNamed: "vortex")
                    node.name = "vortex"
                    addRotation(node: node)
                    addNodePhysics(node: node)
                    addNodeToView(node: node, position: position)
                } else if letter == "s" {
                    let node = SKSpriteNode(imageNamed: "star")
                    node.name = "star"
                    addNodePhysics(node: node)
                    addNodeToView(node: node, position: position)
                } else if letter == "f" {
                    let node = SKSpriteNode(imageNamed: "finish")
                    node.name = "finish"
                    addNodePhysics(node: node)
                    addNodeToView(node: node, position: position)
                } else if letter == "t" {
                    let node = SKSpriteNode(imageNamed: "teleport")
                    node.name = "teleport"
                    addRotation(node: node)
                    addNodePhysics(node: node)
                    addNodeToView(node: node, position: position)
                } else if letter == " " {
                    // this is an empty space-do nothing!
                } else {
                    fatalError("Unkown level letter: \(letter)")
                }
            }
        }
    }
    
    func clearLevel() {
        for node in levelNodes {
            node.removeFromParent()
        }
        levelNodes.removeAll()
    }
    
    func addRotation(node: SKSpriteNode) {
        if node.name == "vortex" || node.name == "teleport" {
            node.run(SKAction.repeatForever(SKAction.rotate(byAngle: .pi, duration: 1)))
        } else {
            return
        }
    }
    
    func addNodePhysics(node: SKSpriteNode) {
        if node.name == "vortex" || node.name == "star" || node.name == "finish" || node.name == "teleport" {
            node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
            node.physicsBody?.contactTestBitMask = CollisionTypes.player.rawValue
            node.physicsBody?.collisionBitMask = 0
        } else {
            node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
        }
        
        node.physicsBody?.isDynamic = false
        
        if node.name == "block" {
            node.physicsBody?.categoryBitMask = CollisionTypes.wall.rawValue
        } else if node.name == "vortex" {
            node.physicsBody?.categoryBitMask = CollisionTypes.vortex.rawValue
        } else if node.name == "star" {
            node.physicsBody?.categoryBitMask = CollisionTypes.star.rawValue
        } else if node.name == "finish" {
            node.physicsBody?.categoryBitMask = CollisionTypes.finish.rawValue
        } else if node.name == "teleport" {
            node.physicsBody?.categoryBitMask = CollisionTypes.teleport.rawValue
        }
    }
    
    func addNodeToView(node: SKSpriteNode, position: CGPoint) {
        node.position = position
        addChild(node)
        levelNodes.append(node)
    }
    
    func createPlayer(position: CGPoint) {
        teleportContact = false
        player = SKSpriteNode(imageNamed: "player")
        player.position = position
        player.zPosition = 1
        
        player.physicsBody = SKPhysicsBody(circleOfRadius: player.size.width / 2)
        player.physicsBody?.allowsRotation = false
        player.physicsBody?.linearDamping = 0.5

        player.physicsBody?.categoryBitMask = CollisionTypes.player.rawValue
        player.physicsBody?.contactTestBitMask = CollisionTypes.star.rawValue | CollisionTypes.vortex.rawValue | CollisionTypes.finish.rawValue | CollisionTypes.teleport.rawValue
        player.physicsBody?.collisionBitMask = CollisionTypes.wall.rawValue
        addChild(player)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        lastTouchPosition = location
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        lastTouchPosition = location
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastTouchPosition = nil
    }
    
    override func update(_ currentTime: TimeInterval) {
        guard isGameOver == false else { return }
        #if targetEnvironment(simulator)
        if let lastTouchPosition = lastTouchPosition {
            let diff = CGPoint(x: lastTouchPosition.x - player.position.x, y: lastTouchPosition.y - player.position.y)
            physicsWorld.gravity = CGVector(dx: diff.x / 100, dy: diff.y / 100)
        }
        #else
        if let accelerometerData = motionManager?.accelerometerData {
            physicsWorld.gravity = CGVector(dx: accelerometerData.acceleration.y * -50, dy: accelerometerData.acceleration.x * 50)
        }
        #endif
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        
        if nodeA == player {
            playerCollided(with: nodeB)
        } else if nodeB == player {
            playerCollided(with: nodeA)
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        teleportContact = false
    }
    
    func teleport(fromNode: SKNode) {
        for node in levelNodes {
            if node.name == "teleport" {
                if node.position != fromNode.position {
                    createPlayer(position: node.position)
                    player.physicsBody?.isDynamic = true
                } else {
                    continue
                }
            }
        }
        teleportContact.toggle()
    }
    
    func playerCollided(with node: SKNode) {
        if node.name == "vortex" {
            player.physicsBody?.isDynamic = false
            isGameOver = true
            score -= 1
            
            let move = SKAction.move(to: node.position, duration: 0.25)
            let scale = SKAction.scale(to: 0.0001, duration: 0.25)
            let remove = SKAction.removeFromParent()
            let sequence = SKAction.sequence([move, scale, remove])
            player.run(sequence) { [weak self] in
                self?.createPlayer(position: self!.startPosition)
                self?.isGameOver = false
            }
        } else if node.name == "star" {
            node.removeFromParent()
            score += 1
        } else if node.name == "teleport" {
            teleportContact.toggle()
            if teleportContact {
                player.physicsBody?.isDynamic = false
                let move = SKAction.move(to: node.position, duration: 0.25)
                let scale = SKAction.scale(to: 0.0001, duration: 0.25)
                let remove = SKAction.removeFromParent()
                let sequence = SKAction.sequence([move,scale,remove])
                player.run(sequence) { [weak self] in
                    self?.teleport(fromNode: node)
                }
            }
        } else if node.name == "finish" {
            player.removeFromParent()
            clearLevel()
            level += 1
            loadLevel(level: level)
            createPlayer(position: startPosition)
        }
    }
}
    

