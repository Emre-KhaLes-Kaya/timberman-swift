//
//  Settings.swift
//  TimberJim
//
//  Created by Jeremy Novak on 10/18/16.
//  Copyright © 2016 SpriteKit Book. All rights reserved.
//

import Foundation

class Settings {
    
    static let sharedInstance = Settings()
    
    // MARK: - Private class constants
    private let defaults = UserDefaults.standard
    private let keyFirstRun = "FirstRun"
    private let keyBestScore = "BestScore"
    
    // MARK: - Init
    init() {
        if defaults.object(forKey: keyFirstRun) == nil {
            firstLaunch()
        }
    }
    
    // MARK: - Private functions
    private func firstLaunch() {
        defaults.set(0, forKey: keyBestScore)
        defaults.set(false, forKey: keyFirstRun)
        defaults.synchronize()
    }
    
    // MARK: - Public saving functions
    func saveBest(score: Int) {
        defaults.set(score, forKey: keyBestScore)
        defaults.synchronize()
    }
    
    
    // MARK: - Public retrieving functions
    func getBestScore() -> Int {
        return defaults.integer(forKey: keyBestScore)
    }
}
