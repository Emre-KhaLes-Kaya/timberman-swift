//
//  GameScene.swift
//  TimberJim
//
//  Created by Jeremy Novak on 10/7/16.
//  Copyright © 2016 SpriteKit Book. All rights reserved.
//

import SpriteKit

class GameScene:SKScene {
    
    // MARK: - Private class constants
    private let clouds = Clouds()
    private let birds = Birds()
    private let logController = LogController()
    
    // MARK: - Private class variables
    private var lastUpdateTime:TimeInterval = 0.0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    override func didMove(to view: SKView) {
        setup()
    }
    
    // MARK: - Setup
    private func setup() {
        self.addChild(clouds)
        self.addChild(birds)
        
        let forest = Textures.sharedInstance.spriteWith(name: SpriteName.forest)
        forest.anchorPoint = CGPoint.zero
        forest.position = CGPoint.zero
        self.addChild(forest)
        
        self.addChild(logController)
    }
    
    // MARK: - Update
    override func update(_ currentTime: TimeInterval) {
        let delta = currentTime - lastUpdateTime
        lastUpdateTime = currentTime
        
        clouds.update(delta: delta)
        birds.update(delta: delta)
        logController.update(delta: delta)
    }
    
    // MARK: - Touch Events
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
}
