//
//  GameScene.swift
//  TimberJim
//
//  Created by Jeremy Novak on 10/7/16.
//  Copyright © 2016 SpriteKit Book. All rights reserved.
//

import SpriteKit

class GameScene:SKScene, SKPhysicsContactDelegate {
    
    // MARK: - Private class enum
    private enum State {
        case waiting, running, gameOver, paused
    }
    
    // MARK: - Private class constants
    private let clouds = Clouds()
    private let birds = Birds()
    private let logController = LogController()
    private let jim = Jim()
    private let tutorial = Tutorial()
    private let playButton = PlayButton()
    //private let scoreboard = Scoreboard()
    private let scoreLabel = ScoreLabel()
    private let timer = Timer()
    private let gameNode = SKNode()
    private let interfaceNode = SKNode()
    private let pauseButton = PauseButton()
    
    // MARK: - Private class variables
    private var lastUpdateTime:TimeInterval = 0.0
    private var state:State = .waiting
    private var previousState:State = .waiting
    private var timeLeft:TimeInterval = 6.0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    override func didMove(to view: SKView) {
        setup()
        setupPhysics()
    }
    
    // MARK: - Setup
    private func setup() {
        self.backgroundColor = SKColor.black
        
        self.addChild(gameNode)
        
        gameNode.addChild(clouds)
        gameNode.addChild(birds)
        
        let forest = Textures.sharedInstance.spriteWith(name: SpriteName.forest)
        forest.anchorPoint = CGPoint.zero
        forest.position = CGPoint.zero
        gameNode.addChild(forest)
        
        gameNode.addChild(logController)
        
        gameNode.addChild(jim)
        
        gameNode.addChild(tutorial)
        tutorial.animateIn()
        
        gameNode.addChild(scoreLabel)
        gameNode.addChild(timer)
        
        self.addChild(interfaceNode)
        interfaceNode.addChild(pauseButton)
    }
    
    private func setupPhysics() {
         self.physicsWorld.contactDelegate = self
         self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
    }
    
    // MARK: - Update
    override func update(_ currentTime: TimeInterval) {
        let delta = currentTime - lastUpdateTime
        lastUpdateTime = currentTime
        
        switch state {
            case .waiting:
                clouds.update(delta: delta)
                birds.update(delta: delta)
            
            case .running:
                clouds.update(delta: delta)
                birds.update(delta: delta)
            
                timeLeft -= delta * 4
                
                timer.updateTimer(seconds: timeLeft)
                
                if timeLeft <= 0 {
                    stateGameOver()
                }
            
            case .gameOver:
                clouds.update(delta: delta)
                birds.update(delta: delta)
            
            case .paused:
                return
        }
    }
    
    // MARK: - Touch Events
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch:UITouch = touches.first! as UITouch
        let touchLocation = touch.location(in: self)
        
        if pauseButton.contains(touchLocation) {
            pausePressed()
        } else {
            switch state {
                case .waiting:
                    stateRunning()
                    
                case .running:
                    if touchLocation.x < kScreenCenter.x {
                        jim.chopLeft()
                    } else if touchLocation.x > kScreenCenter.x {
                        jim.chopRight()
                    }
                    
                    logController.moveStack()
                    scoreLabel.updateLabel(score: jim.getTaps())
                    addSecondToTime()
                    
                case .gameOver:
                    if playButton.contains(touchLocation) {
                        playButton.tapped()
                        resetGame()
                    }
                    
                case .paused:
                    return
                }
        }
    }
    
    // MARK: - Contact
    func didBegin(_ contact: SKPhysicsContact) {
        
        let other = contact.bodyA.categoryBitMask == Contact.jim ? contact.bodyB : contact.bodyA
        
        if other.categoryBitMask == Contact.branch {
            stateGameOver()
        }
    }
    
    // MARK: - States
    private func stateRunning() {
        previousState = state
        state = .running
        
        tutorial.animateOut()
        
        if kDebug {
            print("Running")
        }
    }
    
    private func stateGameOver() {
        state = .gameOver
        
        jim.gameOver()
        
        shake()
        
        displayGameOver()
        
        if kDebug {
            print("Game Over!")
        }
    }
    
    func statePaused() {
        previousState = state
        state = .paused
        
        gameNode.isPaused = true
        gameNode.speed = 0.0
        self.physicsWorld.speed = 0.0
        
        if kDebug {
            print("Paused")
        }
    }
    
    func stateResume() {
        state = previousState
        
        gameNode.isPaused = false
        gameNode.speed = 1.0
        self.physicsWorld.speed = 1.0
        
        if kDebug {
            print("State: \(state)")
        }
    }
    
    private func addSecondToTime() {
        
        if timeLeft < 6.0 {
            timeLeft += 1.0
        } else {
            timeLeft = 6.0
        }
        
        timer.updateTimer(seconds: timeLeft)
    }
    
    private func shake() {
        gameNode.run(SKAction.shake(amount: CGPoint(x: 16, y: 16), duration: 0.5))
    }
    
    private func displayGameOver() {
        self.run(SKAction.wait(forDuration: 0.5), completion: {
            self.addChild(self.playButton)
            self.playButton.animateIn()
            
            let scoreboard = Scoreboard(score: self.jim.getTaps())
            self.addChild(scoreboard)
            scoreboard.animateIn()
        })
    }
    
    private func pausePressed() {
        pauseButton.tapped()
        
        if pauseButton.getPauseState() {
            statePaused()
        } else {
            stateResume()
        }
    }
    
    private func resetGame() {
        let scene = GameScene(size: kViewSize)
        let transition = SKTransition.fade(with: SKColor.black, duration: 1.0)
        
        self.view?.presentScene(scene, transition: transition)
    }
    
}
