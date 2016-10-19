//
//  Sound.swift
//  TimberJim
//
//  Created by Jeremy Novak on 10/19/16.
//  Copyright © 2016 SpriteKit Book. All rights reserved.
//

import SpriteKit
import AVFoundation

enum SoundEffect {
    case button, chop, gameOver, highScore
}

class Sound {
    
    static let sharedInstance = Sound()
    
    // MARK: - Private class constants
    private let music = "Happy.mp3"
    private let button = "Button.caf"
    private let chop = "Chop.caf"
    private let gameOver = "GameOver.caf"
    private let highScore = "HighScore.caf"
    
    // MARK: - Private class variables
    private var player = AVAudioPlayer()
    private var initialized = false
    
    // MARK: - Music player
    func playMusic() {
        let url = URL(fileURLWithPath: Bundle.main.path(forResource: music, ofType: nil)!)
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
        } catch let error as NSError {
            NSLog("Error playing music: %@", error)
        }
        
        player.numberOfLoops = -1
        player.volume = 0.25
        player.prepareToPlay()
        player.play()
        
        initialized = true
    }
    
    func stopMusic() {
        if player.isPlaying {
            player.stop()
        }
    }
    
    func pauseMusic() {
        if player.isPlaying {
            player.pause()
        }
    }
    
    func resumeMusic() {
        if initialized {
            player.play()
        } else {
            playMusic()
        }
    }
    
    // MARK: - Sound Effects
    func playSound(sound: SoundEffect) -> SKAction {
        var file = String()
        
        switch sound {
        case .button:
            file = button
            
        case .chop:
            file = chop
            
        case .gameOver:
            file = gameOver
            
        case .highScore:
            file = highScore
        }
        
        return SKAction.playSoundFileNamed(file, waitForCompletion: false)
    }
}
