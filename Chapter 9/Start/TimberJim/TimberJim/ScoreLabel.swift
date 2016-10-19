//
//  ScoreLabel.swift
//  TimberJim
//
//  Created by Jeremy Novak on 10/18/16.
//  Copyright © 2016 SpriteKit Book. All rights reserved.
//

import SpriteKit

class ScoreLabel: SKNode {
    
    // MARK: - Private class constants
    private let label = BMGlyphLabel(txt: "0", fnt: BMGlyphFont(name: "GameFont"))
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init() {
        super.init()
        
        setup()
    }
    
    // MARK: - Setup
    private func setup() {
        label.position = CGPoint(x: kViewSize.width / 2, y: kViewSize.height * 0.7)
        label.setScale(2.0)
        
        self.addChild(label)
    }
    
    // MARK: - Actions
    func updateLabel(score: Int) {
        label.setGlyphText(String(score))
    }
}
