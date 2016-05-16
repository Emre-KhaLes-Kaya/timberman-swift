//
//  GameViewController.swift
//  TimberJim
//
//  Created by Jeremy Novak on 3/4/16.
//  Copyright (c) 2016 Jeremy Novak. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    override func viewDidLayoutSubviews() {

        super.viewDidLayoutSubviews()
        
        if let skView = self.view as? SKView {
            if (skView.scene == nil) {
                if kDebug {
                    skView.showsFPS = true
                    skView.showsPhysics = true
                    skView.showsNodeCount = true
                }
                
                skView.ignoresSiblingOrder = false
                
                let scene = GameScene(size: kViewSize)
                scene.scaleMode = SKSceneScaleMode.AspectFill
                
                let transition = SKTransition.fadeWithColor(SKColor.blackColor(), duration: 0.25)
                
                skView.presentScene(scene, transition: transition)

                OALSimpleAudio.sharedInstance().preloadEffect("Chop.caf")
                OALSimpleAudio.sharedInstance().preloadEffect("GameOver.caf")
                
                OALSimpleAudio.sharedInstance().preloadBg("SpiritualMoments.mp3")
                OALSimpleAudio.sharedInstance().playBg("SpiritualMoments.mp3", loop: true)
            }
        }
    }
    
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
