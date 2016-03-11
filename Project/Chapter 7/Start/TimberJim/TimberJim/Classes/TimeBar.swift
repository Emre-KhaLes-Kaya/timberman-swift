//
//  TimeBar.swift
//  TimberJim
//
//  Created by Jeremy Novak on 3/10/16.
//  Copyright © 2016 Jeremy Novak. All rights reserved.
//

import SpriteKit

class TimeBar:SKNode {
    
    let timeBar = GameTextures.sharedInstance.spriteWithName(name: SpriteName.TimeBar)
    
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
        // Background
        let background = GameTextures.sharedInstance.spriteWithName(name: SpriteName.TimeBarBackground)
        background.position = CGPoint(x: kViewSize.width / 2, y: kViewSize.height * 0.85)
        self.addChild(background)
        
        // Time bar
        self.timeBar.anchorPoint = CGPoint(x: 0, y: 0.5)
        self.timeBar.position = CGPoint(x: -self.timeBar.size.width / 2, y: 0)
        background.addChild(self.timeBar)
    }
    
    // MARK: - Actions
    func updateTimeBar(seconds seconds: NSTimeInterval) {
        if seconds > 6.0 {
            return
        }
        
        
        if seconds > 0 {
            self.timeBar.xScale = CGFloat(seconds / 6)
        } else {
            self.timeBar.hidden = true
        }
    }
    
}
