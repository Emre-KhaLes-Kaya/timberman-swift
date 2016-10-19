//
//  Jim.swift
//  TimberJim
//
//  Created by Jeremy Novak on 10/14/16.
//  Copyright © 2016 SpriteKit Book. All rights reserved.
//

import SpriteKit

class Jim: SKSpriteNode {
    
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
        let texture = Textures.sharedInstance.textureWith(name: SpriteName.player0)
        
        self.init(texture: texture, color: SKColor.white, size: texture.size())
        
        setup()
        setupPhysics()
    }
    
    // MARK: - Setup
    private func setup() {
        self.position = leftSide
        
        let frame0 = Textures.sharedInstance.textureWith(name: SpriteName.player0)
        let frame1 = Textures.sharedInstance.textureWith(name: SpriteName.player1)
        let frame2 = Textures.sharedInstance.textureWith(name: SpriteName.player2)
        
        animationIdle = SKAction.animate(with: [frame0, frame1], timePerFrame: 0.25)
        
        animationChop = SKAction.animate(with: [frame2], timePerFrame: 0.032)
        
        self.run(SKAction.repeatForever(animationIdle))
    }
    
    private func setupPhysics() {
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.height / 3)
        self.physicsBody?.categoryBitMask = Contact.jim
        self.physicsBody?.collisionBitMask = 0x0
        self.physicsBody?.contactTestBitMask = Contact.branch
    }
    
    
    // MARK: - Chop
    func chopLeft() {
        taps += 1
        
        self.position = leftSide
        
        self.xScale = 1
        
        self.run(animationChop)
    }
    
    func chopRight() {
        taps += 1
        
        self.position = rightSide
        
        self.xScale = -1
        
        self.run(animationChop)
    }
    
    func getTaps() -> Int {
        return taps
    }
    
    func gameOver() {
        if taps > Settings.sharedInstance.getBestScore() {
            Settings.sharedInstance.saveBest(score: taps)
        }
    }
    
}
