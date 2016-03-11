//
//  PauseButton.swift
//  TimberJim
//
//  Created by Jeremy Novak on 3/10/16.
//  Copyright © 2016 Jeremy Novak. All rights reserved.
//

import SpriteKit

class PauseButton:SKSpriteNode {
    
    private let pauseTexture = GameTextures.sharedInstance.textureWithName(name: SpriteName.PauseButton)
    private let resumeTexture = GameTextures.sharedInstance.textureWithName(name: SpriteName.ResumeButton)
    
    // MARK: - Private class variables
    private var gamePaused = false
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    convenience init() {
        let texture = GameTextures.sharedInstance.textureWithName(name: SpriteName.PauseButton)
        self.init(texture: texture, color: SKColor.whiteColor(), size: texture.size())
        
        self.setup()
    }
    
    // MARK: - Setup
    private func setup() {
        self.anchorPoint = CGPoint(x: 1.0, y: 1.0)
        self.position = CGPoint(x: kViewSize.width, y: kViewSize.height)
    }
    
    // MARK: - Actions
    func tapped() {
        // Flip the value of gamePaused
        self.gamePaused = !self.gamePaused
        
        // Which texture should we use?
        self.texture = self.gamePaused ? self.resumeTexture : self.pauseTexture
    }
    
    func getPauseState() -> Bool {
        return self.gamePaused
    }
}
