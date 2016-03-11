//
//  Scoreboard.swift
//  TimberJim
//
//  Created by Jeremy Novak on 3/11/16.
//  Copyright © 2016 Jeremy Novak. All rights reserved.
//

import SpriteKit

class Scoreboard:SKNode {
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init() {
        super.init()
    }
    
    convenience init(score: Int) {
        self.init()
        
        self.setup(score: score)
    }
    
    // MARK: - Setup
    private func setup(score score: Int) {
        self.position = CGPoint(x: kViewSize.width  / 2, y: kViewSize.height * 0.6)
        
        let background = GameTextures.sharedInstance.spriteWithName(name: SpriteName.Scoreboard)
        self.addChild(background)
        
        // Glyph Font
        let font = BMGlyphFont(name: "GameFont")
        
        // Score label
        let currentScore = BMGlyphLabel(txt: String(score), fnt: font)
        currentScore.position = CGPoint(x: 0, y: background.size.height * 0.15 )
        currentScore.textJustify = BMGlyphLabel.BMGlyphJustify.Left
        
        // Best score label
        let bestScore = BMGlyphLabel(txt: String(GameSettings.sharedInstance.getBestScore()), fnt: font)
        bestScore.position = CGPoint(x: 0, y: -background.size.height * 0.25)
        bestScore.textJustify = BMGlyphLabel.BMGlyphJustify.Left
        
        background.addChild(currentScore)
        background.addChild(bestScore)
        
        self.setScale(0)
    }
    
    // MARK: - Actions
    func animateIn() {
        self.runAction(SKAction.scaleTo(1.1, duration: 0.25), completion: {
            self.runAction(SKAction.scaleTo(1.0, duration: 0.25))
        })
    }
}
