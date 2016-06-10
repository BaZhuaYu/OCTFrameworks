//
//  SL+CGVector.swift
//  MyGame
//
//  Created by yuhan zhang on 4/10/16.
//  Copyright © 2016 octopus. All rights reserved.
//

import CoreGraphics


public func *(a: CGVector, factor: CGFloat) -> CGVector {
    return CGVector(dx: a.dx * factor, dy: a.dy * factor)
}