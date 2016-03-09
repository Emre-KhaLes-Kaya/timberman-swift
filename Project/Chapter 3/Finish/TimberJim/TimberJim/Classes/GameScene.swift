//
//  GameScene.swift
//  TimberJim
//
//  Created by Jeremy Novak on 3/4/16.
//  Copyright (c) 2016 Jeremy Novak. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    // MARK: - Private class constants
    private let clouds = Clouds()
    private let birds = Birds()
    private let stackController = StackController()
    
    // MARK: - Private class variables
    private var lastUpdateTime:NSTimeInterval = 0.0
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        
        self.setupScene()
    }
    
    override func didMoveToView(view: SKView) {
    }
    
    // MARK: - Setup
    private func setupScene() {
        self.addChild(self.clouds)
        
        self.addChild(self.birds)
        
        let forest = GameTextures.sharedInstance.spriteWithName(name: SpriteName.Forest)
        forest.anchorPoint = CGPointZero
        forest.position = CGPointZero
        self.addChild(forest)
        
        
        self.addChild(self.stackController)
    }
    
    // MARK: - Touch Events
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch:UITouch = touches.first! as UITouch
        let touchLocation = touch.locationInNode(self)
        
        
        if kDebug {
            print(touchLocation)
        }
    }
    
    
    // MARK: - Update
    override func update(currentTime: NSTimeInterval) {
        let delta = currentTime - self.lastUpdateTime
        self.lastUpdateTime = currentTime
        
        self.clouds.update(delta: delta)
        
        self.birds.update(delta: delta)
        
        self.stackController.update(delta: delta)
    }
    
    // MARK: - De-Init
    deinit {
        if kDebug {
            print("Destroying GameScene")
        }
    }
}
