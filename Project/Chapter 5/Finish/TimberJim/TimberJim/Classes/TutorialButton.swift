//
//  TutorialButton.swift
//  TimberJim
//
//  Created by Jeremy Novak on 3/10/16.
//  Copyright © 2016 Jeremy Novak. All rights reserved.
//

import SpriteKit

class TutorialButton:SKNode {
    
    // MARK: - Private class constants
    private let leftTap = GameTextures.sharedInstance.spriteWithName(name: SpriteName.TapLeft)
    private let rightTap = GameTextures.sharedInstance.spriteWithName(name: SpriteName.TapRight)
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init() {
        super.init()
        
        self.setup()
    }
    
    // MARK: - Setup
    private func setup() {
        self.leftTap.position = CGPoint(x: 0 - self.leftTap.size.width, y: kViewSize.height * 0.2)
        self.rightTap.position = CGPoint(x: kViewSize.width + self.rightTap.size.width, y: kViewSize.height * 0.2)
        
        self.addChild(self.leftTap)
        self.addChild(self.rightTap)
    }
    
    // MARK: - Animations
    func animateIn() {
        let leftAction = SKAction.moveTo(CGPoint(x: kViewSize.width * 0.15, y: kViewSize.height * 0.2), duration: 0.5)
        let rightAction = SKAction.moveTo(CGPoint(x: kViewSize.width * 0.85, y: kViewSize.height * 0.2), duration: 0.5)
        
        self.leftTap.runAction(leftAction)
        self.rightTap.runAction(rightAction)
        
        let scaleUp = SKAction.scaleTo(1.1, duration: 0.25)
        let scaleNormal = SKAction.scaleTo(1.0, duration: 0.25)
        let scaleSequence = SKAction.sequence([scaleUp, scaleNormal])
        
        self.leftTap.runAction(SKAction.repeatActionForever(scaleSequence))
        self.rightTap.runAction(SKAction.repeatActionForever(scaleSequence))
    }
    
    func animateOut() {
        self.leftTap.removeAllActions()
        self.rightTap.removeAllActions()
        
        let leftAction = SKAction.moveTo(CGPoint(x: 0 - self.leftTap.size.width, y: kViewSize.height * 0.2), duration: 0.25)
        let rightAction = SKAction.moveTo(CGPoint(x: kViewSize.width + self.rightTap.size.width, y: kViewSize.height * 0.2), duration: 0.25)
        
        self.leftTap.runAction(leftAction)
        self.rightTap.runAction(rightAction)
    }
}
