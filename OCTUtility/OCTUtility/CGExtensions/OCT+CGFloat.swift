//
//  CGFloatExtension.swift
//  Untold
//
//  Created by yuhan zhang on 11/6/15.
//  Copyright © 2015 octopus. All rights reserved.
//

import UIKit

extension CGFloat {
    public static func random(from min: CGFloat, to max: CGFloat) -> CGFloat {
        if (min > max) {
            return CGFloat(0)
        } else {
            return CGFloat(arc4random_uniform(UInt32(max) - UInt32(min)) + UInt32(min))
        }
    }
    
    public static func random(max: CGFloat) -> CGFloat {
        return self.random(from: 0, to: max)
    }
    
    public static func random(from min: CGFloat, range: CGFloat) -> CGFloat {
        return self.random(from: min, to: min+range)
    }
}

