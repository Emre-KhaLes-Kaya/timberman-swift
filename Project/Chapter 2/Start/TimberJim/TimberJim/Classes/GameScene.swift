//
//  GameScene.swift
//  TimberJim
//
//  Created by Jeremy Novak on 3/4/16.
//  Copyright (c) 2016 Jeremy Novak. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
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
        self.backgroundColor = SKColor.blackColor()
        
        let font = BMGlyphFont(name: "GameFont")
        let label = BMGlyphLabel(text: "Yay, it works!", font: font)
        label.position = CGPoint(x: kViewSize.width / 2, y: kViewSize.height / 2)
        self.addChild(label)
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
        
        if kDebug {
            print(delta)
        }
    }
    
    // MARK: - De-Init
    deinit {
        if kDebug {
            print("Destroying GameScene")
        }
    }
}
