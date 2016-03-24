//
//  Birds.swift
//  TimberJim
//
//  Created by Jeremy Novak on 3/7/16.
//  Copyright © 2016 Jeremy Novak. All rights reserved.
//

import SpriteKit

class Birds:SKSpriteNode {
    
    // MARK: - Public class enum
    private enum Direction:Int {
        case Left, Right
    }
    
    // MARK: - Private class variables
    private var birdsAnimation = SKAction()
    private var direction = Direction.Left
    private var moving:Bool = false
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    convenience init() {
        let texture = GameTextures.sharedInstance.textureWithName(name: SpriteName.Birds0)
        
        self.init(texture: texture, color: SKColor.whiteColor(), size: texture.size())
        
        self.setupBirds()
        self.setupBirdsAnimation()
    }
    
    // MARK: - Setup
    private func setupBirds() {
        let randomY = self.randomFloatRange(min: kViewSize.height * 0.45, max: kViewSize.height * 0.9)
        
        self.position = CGPoint(x: kViewSize.width, y: randomY)
        
        self.runAction(SKAction.waitForDuration(0.016), completion: {
            self.moving = true
        })
    }
    
    private func setupBirdsAnimation() {
        let frame0 = GameTextures.sharedInstance.textureWithName(name: SpriteName.Birds0)
        let frame1 = GameTextures.sharedInstance.textureWithName(name: SpriteName.Birds1)
        
        self.birdsAnimation = SKAction.animateWithTextures([frame0, frame1], timePerFrame: 0.1)
        
        self.runAction(SKAction.repeatActionForever(self.birdsAnimation))
    }
    
    
    // MARK: - Update
    func update(delta delta: NSTimeInterval) {
        if self.moving {
            let speedX = kDeviceTablet ? CGFloat(delta) * 60 * 3 : CGFloat(delta) * 60 * 1.5
            
            switch self.direction {
                
            case Direction.Left:
                
                self.position.x -= speedX
                
                if self.position.x < (0 - self.size.width) {
                    self.changeDirection()
                }
                
                
            case Direction.Right:
                
                self.position.x += speedX
                
                if self.position.x > (kViewSize.width + self.size.width) {
                    self.changeDirection()
                }
            }
            
        }
    }
    
    // MARK: - Direction
    private func changeDirection() {
        self.position.y = self.randomFloatRange(min: kViewSize.height * 0.45, max: kViewSize.height * 0.9)
        
        self.xScale = self.xScale * -1
        
        self.direction = self.direction == Direction.Left ? Direction.Right : Direction.Left
    }
    
    // MARK: - Math functions
    private func randomFloatRange(min min: CGFloat, max: CGFloat) -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF) * (max - min) + min
    }
}
