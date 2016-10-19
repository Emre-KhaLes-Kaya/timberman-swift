//
//  PauseButton.swift
//  TimberJim
//
//  Created by Jeremy Novak on 10/19/16.
//  Copyright © 2016 SpriteKit Book. All rights reserved.
//

import SpriteKit

class PauseButton: SKSpriteNode {
    
    // MARK: - Private class constants
    private let pause = Textures.sharedInstance.textureWith(name: SpriteName.pauseButton)
    private let resume = Textures.sharedInstance.textureWith(name: SpriteName.resumeButton)
    
    
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
        let texture = Textures.sharedInstance.textureWith(name: SpriteName.pauseButton)
        
        self.init(texture: texture, color: SKColor.white, size: texture.size())
        
        setup()
    }
    
    // MARK: - Setup
    private func setup() {
        self.anchorPoint = CGPoint(x: 1.0, y: 1.0)
        self.position = CGPoint(x: kViewSize.width, y: kViewSize.height)
    }

    // MARK: - Actions
    func tapped() {
        // Flip the value of gamePaused
        gamePaused = !gamePaused
        
        // Which texture should we use?
        self.texture = gamePaused ? resume : pause
        
        // Play the button clip
        self.run(Sound.sharedInstance.playSound(sound: .button))
        
        // Pause or resume background music.
        if gamePaused {
            Sound.sharedInstance.pauseMusic()
        } else {
            Sound.sharedInstance.resumeMusic()
        }
    }
    
    func getPauseState() -> Bool {
        return gamePaused
    }
    
}

