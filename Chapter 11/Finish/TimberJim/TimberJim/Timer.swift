//
//  Timer.swift
//  TimberJim
//
//  Created by Jeremy Novak on 10/18/16.
//  Copyright © 2016 SpriteKit Book. All rights reserved.
//

import SpriteKit

class Timer: SKNode {
    
    // MARK: - Private class constants
    let bar = Textures.sharedInstance.spriteWith(name: SpriteName.timeBar)
    
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
        // Background
        let background = Textures.sharedInstance.spriteWith(name: SpriteName.timeBarBackground)
        background.position = CGPoint(x: kViewSize.width / 2, y: kViewSize.height * 0.85)
        self.addChild(background)
        
        // Time bar
        bar.anchorPoint = CGPoint(x: 0, y: 0.5)
        bar.position = CGPoint(x: -bar.size.width / 2, y: 0)
        background.addChild(bar)
    }
    
    
    // MARK: - Actions
    func updateTimer(seconds: TimeInterval) {
        if seconds > 6.0 {
            return
        }
        
        
        if seconds > 0 {
            bar.xScale = CGFloat(seconds / 6)
        } else {
            bar.isHidden = true
        }
    }
    
}
