//
//  Math.swift
//  TimberJim
//
//  Created by Jeremy Novak on 10/14/16.
//  Copyright © 2016 SpriteKit Book. All rights reserved.
//

import SpriteKit

func RandomFloatBetween(min: CGFloat, max: CGFloat) -> CGFloat {
    return CGFloat(Float(arc4random()) / 0xFFFFFFFF) * (max - min) + min
}

func Clamp(value: CGFloat, min: CGFloat, max: CGFloat) -> CGFloat {
    
    var newMin = min
    var newMax = max
    
    if (min > max) {
        newMin = max
        newMax = min
    }
    
    return value < newMin ? newMin : value < newMax ? value : newMax
}
