//
//  Clouds.swift
//  TimberJim
//
//  Created by Jeremy Novak on 3/7/16.
//  Copyright © 2016 Jeremy Novak. All rights reserved.
//

import SpriteKit

class Clouds:SKSpriteNode {
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    convenience init() {
        let texture = GameTextures.sharedInstance.textureWithName(name: SpriteName.Clouds)
        
        self.init(texture: texture, color: SKColor.whiteColor(), size: texture.size())
        
        self.blendMode = SKBlendMode.Replace
        
        self.setupClouds()
    }
    
    // MARK: - Setup
    private func setupClouds() {
        self.anchorPoint = CGPointZero
        self.position = CGPointZero
    }
    
    
    // MARK: - Update
    func update(delta delta: NSTimeInterval) {
        let speedX = kDeviceTablet ? CGFloat(delta) * 60 * 0.5 : CGFloat(delta) * 60 * 0.25
        
        self.position.x -= speedX
        
        if self.position.x < (0 - self.size.width / 2) {
            self.position.x = 0
        }
        
    }
}
