//
//  LogController.swift
//  TimberJim
//
//  Created by Jeremy Novak on 10/14/16.
//  Copyright © 2016 SpriteKit Book. All rights reserved.
//

import SpriteKit

class LogController: SKNode {
    
    // MARK: - Private enum
    private enum Side {
        case left, right, none
    }
    
    // MARK: - Private class variables
    private var branchArray = [SKSpriteNode]()
    private var pieceArray = [SKSpriteNode]()
    private var basePosition = CGPoint.zero
    private var currentSide:Side = .left
    private var frameCount:TimeInterval = 0.0
    
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
        
        let leftBranch = Branch()
        let rightBranch = Branch()
        
        rightBranch.xScale = rightBranch.xScale * -1
        
        branchArray = [leftBranch, rightBranch]
        
        spawnStack()
    }
    
    // MARK: - Spawning
    private func chooseSide() {
        let randomNumber = RandomFloatBetween(min: 0.0, max: 1.0)
        
        if currentSide != .none {
            currentSide = .none
        } else {
            if randomNumber < 0.45 {
                currentSide = .left
                
            } else if randomNumber < 0.9 {
                currentSide = .right
                
            } else {
                currentSide = .none
            }
        }
    }
    
    private func spawnBranch(log: SKSpriteNode) {
        chooseSide()
        
        if currentSide == .left {
            
            let position = CGPoint(x: -log.size.width, y: 0)
            let branch = branchArray[0].copy() as! Branch
            branch.position = position
            
            log.addChild(branch)
            
        } else if currentSide == .right {
            
            let position = CGPoint(x: log.size.width, y: 0)
            let branch = branchArray[1].copy() as! Branch
            branch.position = position
            
            log.addChild(branch)
        }
    }
    
    private func spawnStack() {
        let piece0 = Textures.sharedInstance.spriteWith(name: SpriteName.log0)
        let piece1 = Textures.sharedInstance.spriteWith(name: SpriteName.log1)
        
        let spriteArray = [piece0, piece1]
        
        basePosition = CGPoint(x: kViewSize.width / 2, y: kViewSize.height * 0.3)
        
        for i in 0 ..< 12 {
            let log = spriteArray[i % 2].copy() as! SKSpriteNode
            
            log.position = CGPoint(x: basePosition.x, y: basePosition.y + CGFloat(i) * log.size.height)
            
            spawnBranch(log: log)
            
            self.addChild(log)
            
            pieceArray.append(log)
        }
    }
    
    func moveStack() {
        let oneFrame:TimeInterval = 0.016
        
        self.run(SKAction.wait(forDuration: oneFrame), completion: {
            let log = self.pieceArray[0]
            
            self.pieceArray.append(log)
            
            self.pieceArray.removeFirst()
            
            log.removeAllChildren()
            
            self.spawnBranch(log: log)
            
            // Set position
            for i in 0 ..< self.pieceArray.count {
                let chunk = self.pieceArray[i]
                chunk.position = CGPoint(x: self.basePosition.x, y: self.basePosition.y + CGFloat(i) * chunk.size.height)
            }
        })
    }
    
    // MARK: - Update
    func update(delta:TimeInterval) {
        frameCount += delta
        
        if frameCount >= 1.0 {
            moveStack()
            
            frameCount = 0.0
        }
    }
}
