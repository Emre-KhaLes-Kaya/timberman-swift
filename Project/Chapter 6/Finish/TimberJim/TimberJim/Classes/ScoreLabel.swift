//
//  ScoreLabel.swift
//  TimberJim
//
//  Created by Jeremy Novak on 3/10/16.
//  Copyright © 2016 Jeremy Novak. All rights reserved.
//

import SpriteKit

class ScoreLabel:SKNode {
    
    // MARK: - Private class constants
    private let scoreLabel = BMGlyphLabel(text: "0", font: BMGlyphFont(name: "GameFont"))
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init() {
        super.init()
        
        self.setup()
    }
    
    // MARK: - Setup
    private func setup() {
        self.scoreLabel.position = CGPoint(x: kViewSize.width / 2, y: kViewSize.height * 0.7)
        self.scoreLabel.setScale(2.0)
        
        self.addChild(self.scoreLabel)
    }
    
    // MARK: - Public Actions
    func updateLabel(score score: Int) {
//        self.scoreLabel.setGlyphText(String(score))
        self.scoreLabel.text = String(score)
    }
}
