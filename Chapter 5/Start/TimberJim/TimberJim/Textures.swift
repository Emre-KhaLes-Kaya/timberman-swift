//
//  Textures.swift
//  TimberJim
//
//  Created by Jeremy Novak on 10/12/16.
//  Copyright © 2016 SpriteKit Book. All rights reserved.
//

import SpriteKit

class Textures {
    
    // MARK: - Singleton instance constant
    static let sharedInstance = Textures()
    
    // MARK: - Private class variables
    private var atlas = SKTextureAtlas()
    
    
    // MARK: - Init
    private init() {
        setup()
    }
    
    // MARK: - Setup
    private func setup() {
        atlas = SKTextureAtlas(named: "Sprites")
    }
    
    // MARK: - Public Functions
    func spriteWith(name: String) -> SKSpriteNode {
        let texture = atlas.textureNamed(name)
        return SKSpriteNode(texture: texture)
    }
    
    func textureWith(name: String) -> SKTexture {
        return atlas.textureNamed(name)
    }
}
