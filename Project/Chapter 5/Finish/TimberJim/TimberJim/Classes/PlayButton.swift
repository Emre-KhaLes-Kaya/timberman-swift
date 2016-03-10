//
//  PlayButton.swift
//  TimberJim
//
//  Created by Jeremy Novak on 3/10/16.
//  Copyright © 2016 Jeremy Novak. All rights reserved.
//

import SpriteKit

class PlayButton:SKSpriteNode {
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    convenience init() {
        let texture = GameTextures.sharedInstance.textureWithName(name: SpriteName.PlayButton)
        self.init(texture: texture, color: SKColor.whiteColor(), size: texture.size())
        
        self.setup()
    }
    
    // MARK: - Setup
    private func setup() {
        self.position = CGPoint(x: kViewSize.width / 2, y: kViewSize.height * 0.15)
        self.setScale(0)
    }
    
    func animateIn() {
        self.runAction(SKAction.scaleTo(1.1, duration: 0.25), completion: {
            self.runAction(SKAction.scaleTo(1.0, duration: 0.25))
        })
    }
    
    // MARK: - Actions
    func animateOut() {
        self.runAction(SKAction.scaleTo(1.1, duration: 0.25), completion: {
            self.runAction(SKAction.scaleTo(1.0, duration: 0.25))
        })
    }
}
