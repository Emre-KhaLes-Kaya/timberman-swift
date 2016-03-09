//
//  Branch.swift
//  TimberJim
//
//  Created by Jeremy Novak on 3/7/16.
//  Copyright © 2016 Jeremy Novak. All rights reserved.
//

import SpriteKit

class Branch:SKSpriteNode {
    
    // MARK: - Public enum
    internal enum BranchType {
        case Left, Right
    }
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    convenience init(branchType: BranchType) {
        
        let texture = GameTextures.sharedInstance.textureWithName(name: SpriteName.Branch)
        
        self.init(texture: texture, color: SKColor.whiteColor(), size: texture.size())
        
        
        switch branchType {
        case BranchType.Left:
            self.setupPhysics()
            
        case BranchType.Right:
            self.xScale = self.xScale * -1
            self.setupPhysics()
        }
    }
    
    private func setupPhysics() {
        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.size, center: self.anchorPoint)
        self.physicsBody?.categoryBitMask = Contact.Branch
        self.physicsBody?.collisionBitMask = 0x0
        self.physicsBody?.contactTestBitMask = Contact.Player
        self.physicsBody?.affectedByGravity = false
    }
}
