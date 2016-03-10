//
//  Smoke.swift
//  TimberJim
//
//  Created by Jeremy Novak on 3/9/16.
//  Copyright © 2016 Jeremy Novak. All rights reserved.
//

import SpriteKit

class Smoke:SKSpriteNode {
    
    // MARK: - Private class variables
    private var animation = SKAction()
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    convenience init() {
        let texture = GameTextures.sharedInstance.textureWithName(name: SpriteName.Smoke0)
        self.init(texture: texture, color: SKColor.whiteColor(), size: texture.size())
        
        self.setupSmoke()
    }
    
    // MARK: - Setup
    private func setupSmoke() {
        let frame0 = GameTextures.sharedInstance.textureWithName(name: SpriteName.Smoke0)
        let frame1 = GameTextures.sharedInstance.textureWithName(name: SpriteName.Smoke1)
        let frame2 = GameTextures.sharedInstance.textureWithName(name: SpriteName.Smoke2)
        let frame3 = GameTextures.sharedInstance.textureWithName(name: SpriteName.Smoke3)
        let frame4 = GameTextures.sharedInstance.textureWithName(name: SpriteName.Smoke4)
        
        self.animation = SKAction.animateWithTextures([frame0, frame1, frame2, frame3, frame4], timePerFrame: 0.1)
        
        self.alpha = 0.0
    }
    
    func animateSmoke() {
        self.alpha = 1.0
        
        self.runAction(self.animation, completion:  {
            self.removeFromParent()
        })
    }
}
