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
    
    convenience init(score: Int) {
        let texture = Textures.sharedInstance.textureWith(name: SpriteName.scoreboard)
        
        self.init(texture: texture, color: SKColor.white, size: texture.size())
        
        setup(score: score)
    }
    
    // MARK: - Setup
    private func setup(score: Int) {
        self.position = CGPoint(x: kViewSize.width  / 2, y: kViewSize.height * 0.6)
        
        // Glyph Font
        let font = BMGlyphFont(name: "GameFont")
        
        // Score label
        let currentScore = BMGlyphLabel(txt: String(score), fnt: font)
        currentScore.position = CGPoint(x: 0, y: self.size.height * 0.15 )
        
        // Best score label
        let bestScore = BMGlyphLabel(txt: String(Settings.sharedInstance.getBestScore()), fnt: font)
        bestScore.position = CGPoint(x: 0, y: -self.size.height * 0.25)
        
        self.addChild(currentScore)
        self.addChild(bestScore)
        
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

