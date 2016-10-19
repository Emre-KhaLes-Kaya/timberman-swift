//
//  Clouds.swift
//  TimberJim
//
//  Created by Jeremy Novak on 10/13/16.
//  Copyright © 2016 SpriteKit Book. All rights reserved.
//

import SpriteKit

class Clouds: SKSpriteNode {
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    private override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    convenience init() {
        let texture = Textures.sharedInstance.textureWith(name: SpriteName.clouds)
        
        self.init(texture: texture, color: SKColor.white, size: texture.size())
        
        setup()
    }
    
    // MARK: - Setup
    private func setup() {
        self.anchorPoint = CGPoint.zero
        self.position = CGPoint.zero
    }
    
    // MARK: - Update
    func update(delta: TimeInterval) {
        let speedX = CGFloat(delta) * 60 * 0.25
        
        self.position.x -= speedX
        
        if self.position.x < (0 - self.size.width / 2) {
            self.position.x = 0
        }
    }
    
}

