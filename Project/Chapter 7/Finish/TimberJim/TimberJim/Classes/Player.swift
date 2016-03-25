//
//  Player.swift
//  TimberJim
//
//  Created by Jeremy Novak on 3/9/16.
//  Copyright © 2016 Jeremy Novak. All rights reserved.
//

import SpriteKit

class Player:SKSpriteNode {
    
    // MARK: - Private class constants
    private let leftSide = CGPoint(x: kViewSize.width * 0.22, y: kViewSize.height * 0.27)
    private let rightSide = CGPoint(x: kViewSize.width * 0.78, y: kViewSize.height * 0.27)
    
    // MARK: - Private class variables
    private var animationIdle = SKAction()
    private var animationChop = SKAction()
    private var taps:Int = 0
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    convenience init() {
        let texture = GameTextures.sharedInstance.textureWithName(name: SpriteName.Player0)
        
        self.init(texture: texture, color: SKColor.whiteColor(), size: texture.size())
        
        
        self.setupPlayer()
        self.setupAnimations()
        self.setupPhysics()
    }
    
    // MARK: - Setup
    private func setupPlayer() {
        self.position = self.leftSide
    }
    
    private func setupAnimations() {
        let frame0 = GameTextures.sharedInstance.textureWithName(name: SpriteName.Player0)
        let frame1 = GameTextures.sharedInstance.textureWithName(name: SpriteName.Player1)
        let frame2 = GameTextures.sharedInstance.textureWithName(name: SpriteName.Player2)
        
        self.animationIdle = SKAction.animateWithTextures([frame0, frame1], timePerFrame: 0.25)
        
        self.animationChop = SKAction.animateWithTextures([frame2], timePerFrame: 0.032)
        
        self.runAction(SKAction.repeatActionForever(self.animationIdle))
    }
    
    private func setupPhysics() {
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.height / 3)
        self.physicsBody?.categoryBitMask = Contact.Player
        self.physicsBody?.collisionBitMask = 0x0
        self.physicsBody?.contactTestBitMask = Contact.Branch
        self.physicsBody?.affectedByGravity = false
    }
    
    // MARK: - Chop
    func chopLeft() {
        self.taps += 1
        
        self.position = self.leftSide
        
        self.xScale = 1
        
        self.runAction(self.animationChop)
        
        OALSimpleAudio.sharedInstance().playEffect("Chop.caf")
    }
    
    func chopRight() {
        self.taps += 1
        
        self.position = self.rightSide
        
        self.xScale = -1
        
        self.runAction(self.animationChop)
        
        OALSimpleAudio.sharedInstance().playEffect("Chop.caf")
    }
    
    
    // MARK: - Get Taps
    func getTaps() -> Int {
        return self.taps
    }
    
    
    // MARK: - Animation
    private func animateSmoke() {
        let smoke = Smoke()
        self.addChild(smoke)
        smoke.animateSmoke()
    }
    
    // MARK: - Game Over
    func gameOver() {
        self.removeAllActions()
        
        let texture = GameTextures.sharedInstance.textureWithName(name: SpriteName.Tombstone)
        
        
        if self.position.x > kViewSize.width / 2 {
            self.texture = texture
            self.xScale = -1
        } else {
            self.texture = texture
        }
        
        self.animateSmoke()
        
        OALSimpleAudio.sharedInstance().playEffect("GameOver.caf")
        
        if self.taps > 0 && self.taps > GameSettings.sharedInstance.getBestScore() {
            GameSettings.sharedInstance.saveBestScore(score: self.taps)
        }
    }
}
