//
//  Birds.swift
//  TimberJim
//
//  Created by Jeremy Novak on 10/13/16.
//  Copyright © 2016 SpriteKit Book. All rights reserved.
//

import SpriteKit

class Birds: SKSpriteNode {
    
    // MARK: - Public class enum
    private enum Direction:Int {
        case left, right
    }
    
    // MARK: - Private class variables
    private var direction:Direction = .left
    
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    private override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    convenience init() {
        let texture = Textures.sharedInstance.textureWith(name: SpriteName.birds0)
        
        self.init(texture: texture, color: SKColor.white, size: texture.size())
        
        setup()
    }
    
    // MARK: - Setup
    private func setup() {
        // Get a random height from 45% up the screen to 90% up the screen on the Y axis.
        let randomY = RandomFloatBetween(min: kViewSize.height * 0.45, max: kViewSize.height * 0.9)
        
        // Position
        self.position = CGPoint(x: 0 - self.size.width, y: randomY)
        
        // Animation
        let frame0 = Textures.sharedInstance.textureWith(name: SpriteName.birds0)
        let frame1 = Textures.sharedInstance.textureWith(name: SpriteName.birds1)
        
        let animation = SKAction.animate(with: [frame0, frame1], timePerFrame: 0.1)
        
        self.run(SKAction.repeatForever(animation))
    }
    
    // MARK: - Update
    func update(delta: TimeInterval) {        
        let speedX = CGFloat(delta) * 60 * 1.5
        
        switch direction {
            
        case .left:
            
            self.position.x -= speedX
            
            if self.position.x <= (0 - self.size.width) {
                self.position.x = 0 - self.size.width
                
                changeDirection()
            }
            
            
        case .right:
            
            self.position.x += speedX
            
            if self.position.x >= (kViewSize.width + self.size.width) {
                self.position.x = kViewSize.width + self.size.width
                
                changeDirection()
            }
        }
    }
    
    // MARK: - Direction change
    private func changeDirection() {
        self.position.y = RandomFloatBetween(min: kViewSize.height * 0.45, max: kViewSize.height * 0.9)
        
        self.xScale = self.xScale * -1
        
        direction = direction == .left ? .right : .left
    }
    
}

