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
    private let scoreboard = Scoreboard()
    
    // MARK: - Private class variables
    private var lastUpdateTime:TimeInterval = 0.0
    private var state:State = .waiting
    private var previousState:State = .waiting
    
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
        self.addChild(clouds)
        self.addChild(birds)
        
        let forest = Textures.sharedInstance.spriteWith(name: SpriteName.forest)
        forest.anchorPoint = CGPoint.zero
        forest.position = CGPoint.zero
        self.addChild(forest)
        
        self.addChild(logController)
        
        self.addChild(jim)
        
        self.addChild(tutorial)
        tutorial.animateIn()
    }
    
    private func setupPhysics() {
         self.physicsWorld.contactDelegate = self
         self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
    }
    
    // MARK: - Update
    override func update(_ currentTime: TimeInterval) {
        let delta = currentTime - lastUpdateTime
        lastUpdateTime = currentTime
        
        clouds.update(delta: delta)
        birds.update(delta: delta)
    }
    
    // MARK: - Touch Events
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch:UITouch = touches.first! as UITouch
        let touchLocation = touch.location(in: self)
        
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
        case .gameOver:
            if playButton.contains(touchLocation) {
                resetGame()
            }
            
        case .paused:
            return
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
        
        displayGameOver()
        
        if kDebug {
            print("Game Over!")
        }
    }
    
    func statePaused() {
        previousState = state
        state = .paused
        
        if kDebug {
            print("Paused")
        }
    }
    
    func stateResume() {
        state = previousState
        
        if kDebug {
            print("State: \(state)")
        }
    }
    
    private func displayGameOver() {
        self.run(SKAction.wait(forDuration: 0.5), completion: {
            self.addChild(self.playButton)
            self.playButton.animateIn()
            
            self.addChild(self.scoreboard)
            self.scoreboard.animateIn()
        })
    }
    
    private func resetGame() {
        let scene = GameScene(size: kViewSize)
        let transition = SKTransition.fade(with: SKColor.black, duration: 1.0)
        
        self.view?.presentScene(scene, transition: transition)
    }
    
}
