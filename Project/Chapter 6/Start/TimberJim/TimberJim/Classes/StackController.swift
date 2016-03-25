//
//  StackController.swift
//  TimberJim
//
//  Created by Jeremy Novak on 3/7/16.
//  Copyright © 2016 Jeremy Novak. All rights reserved.
//

import SpriteKit

class StackController:SKNode {
    
    // MARK: - Public enum
    private enum Side {
        case Left, Right, None
    }
    
    // MARK: - Private class variables
    private var branchArray = [SKSpriteNode]()
    private var pieceArray = [SKSpriteNode]()
    private var basePosition:CGPoint = CGPointZero
    private var currentSide = Side.Left
    private var frameCount = 0.0
    
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
        let leftBranch = Branch(branchType: Branch.BranchType.Left)
        let rightBranch = Branch(branchType: Branch.BranchType.Right)
    
        branchArray = [leftBranch, rightBranch]
        
        self.spawnStack()
    }
    
    // MARK: - Stack and Branch
    private func randomFloatRange(min min: CGFloat, max: CGFloat) -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF) * (max - min) + min
    }

    
    private func spawnStack() {
        let piece0 = GameTextures.sharedInstance.spriteWithName(name: SpriteName.Log0)
        let piece1 = GameTextures.sharedInstance.spriteWithName(name: SpriteName.Log1)
        
        let spriteArray = [piece0, piece1]
        
        basePosition = CGPoint(x: kViewSize.width / 2, y: kViewSize.height * 0.3)
        
        for i in 0 ..< 12 {
            let log = spriteArray[i % 2].copy() as! SKSpriteNode
            
            log.position = CGPoint(x: basePosition.x, y: basePosition.y + CGFloat(i) * log.size.height)
            
            self.spawnBranch(log: log)
            
            self.addChild(log)
            
            pieceArray.append(log)
        }
    }
    
    
    private func chooseSide() {
        let randomNumber = self.randomFloatRange(min: 0.0, max: 1.0)
        
        if self.currentSide != Side.None {
            self.currentSide = Side.None
        } else {
            if randomNumber < 0.45 {
                self.currentSide = Side.Left
                
            } else if randomNumber < 0.9 {
                self.currentSide = Side.Right
                
            } else {
                self.currentSide = Side.None
            }
        }
    }
    
    
    private func spawnBranch(log log: SKSpriteNode) {
        
        self.chooseSide()
        
        if self.currentSide == Side.Left {
            let position = CGPoint(x: -log.size.width, y: 0)
            let branch = self.branchArray[0].copy() as! Branch
            branch.position = position
            
            log.addChild(branch)
        } else if self.currentSide == Side.Right {
            let position = CGPoint(x: log.size.width, y: 0)
            let branch = self.branchArray[1].copy() as! Branch
            branch.position = position
            
            log.addChild(branch)
        }
    }
    
    // MARK: - Stack Management
    func moveStack() {
        let oneFrame:NSTimeInterval = 0.016
        
        self.runAction(SKAction.waitForDuration(oneFrame), completion: {
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
    func update(delta delta: NSTimeInterval) {
        self.frameCount += delta
        
        if self.frameCount >= 1.0 {
            self.moveStack()
            
            self.frameCount = 0.0
        }
    }
    
}

