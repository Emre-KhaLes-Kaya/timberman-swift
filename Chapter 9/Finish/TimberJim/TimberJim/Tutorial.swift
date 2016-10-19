//
//  Tutorial.swift
//  TimberJim
//
//  Created by Jeremy Novak on 10/18/16.
//  Copyright © 2016 SpriteKit Book. All rights reserved.
//

import SpriteKit

class Tutorial:SKNode {
    
    // MARK: - Private class constants
    private let leftTap = Textures.sharedInstance.spriteWith(name: SpriteName.tapLeft)
    private let rightTap = Textures.sharedInstance.spriteWith(name: SpriteName.tapRight)
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init() {
        super.init()
        
        setup()
    }
    
    // MARK: - Setup
    private func setup() {
        leftTap.position = CGPoint(x: 0 - leftTap.size.width, y: kViewSize.height * 0.2)
        rightTap.position = CGPoint(x: kViewSize.width + rightTap.size.width, y: kViewSize.height * 0.2)
        
        self.addChild(leftTap)
        self.addChild(rightTap)
    }
    
    // MARK: - Animations
    func animateIn() {
        let leftAction = SKAction.move(to: CGPoint(x: kViewSize.width * 0.15, y: kViewSize.height * 0.2), duration: 0.5)
        let rightAction = SKAction.move(to: CGPoint(x: kViewSize.width * 0.85, y: kViewSize.height * 0.2), duration: 0.5)
        
        leftTap.run(leftAction)
        rightTap.run(rightAction)
        
        let scaleUp = SKAction.scale(to: 1.1, duration: 0.25)
        let scaleNormal = SKAction.scale(to: 1.0, duration: 0.25)
        let scaleSequence = SKAction.sequence([scaleUp, scaleNormal])
        
        leftTap.run(SKAction.repeatForever(scaleSequence))
        rightTap.run(SKAction.repeatForever(scaleSequence))
    }
    
    func animateOut() {
        leftTap.removeAllActions()
        rightTap.removeAllActions()
        
        let leftAction = SKAction.move(to: CGPoint(x: 0 - leftTap.size.width, y: kViewSize.height * 0.2), duration: 0.25)
        let rightAction = SKAction.move(to: CGPoint(x: kViewSize.width + rightTap.size.width, y: kViewSize.height * 0.2), duration: 0.25)
        
        leftTap.run(leftAction)
        rightTap.run(rightAction)
    }
}
