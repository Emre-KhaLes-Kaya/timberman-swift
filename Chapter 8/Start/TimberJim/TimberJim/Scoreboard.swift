//
//  Scoreboard.swift
//  TimberJim
//
//  Created by Jeremy Novak on 10/18/16.
//  Copyright © 2016 SpriteKit Book. All rights reserved.
//

import SpriteKit

class Scoreboard: SKSpriteNode {
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    private override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    convenience init() {
        let texture = Textures.sharedInstance.textureWith(name: SpriteName.scoreboard)
        
        self.init(texture: texture, color: SKColor.white, size: texture.size())
        
        setup()
    }
    
    // MARK: - Setup
    private func setup() {
        self.position = CGPoint(x: kViewSize.width  / 2, y: kViewSize.height * 0.6)
        
        self.setScale(0)
    }
    
    // MARK: - Animations
    func animateIn() {
        self.run(SKAction.scale(to: 1.1, duration: 0.25), completion: {
            self.run(SKAction.scale(to: 1.0, duration: 0.25))
        })
    }
    
    func animateOut() {
        self.run(SKAction.scale(to: 1.1, duration: 0.25), completion: {
            self.run(SKAction.scale(to: 0.0, duration: 0.25))
        })
    }
}

