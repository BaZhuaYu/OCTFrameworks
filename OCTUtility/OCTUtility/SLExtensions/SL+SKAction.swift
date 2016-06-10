//
//  SL+SKAction.swift
//  MyGame
//
//  Created by yuhan zhang on 4/12/16.
//  Copyright © 2016 octopus. All rights reserved.
//

import SpriteKit

extension SKAction {
    public class func showUp(duration: NSTimeInterval) -> SKAction {
        return SKAction.sequence([
            SKAction.fadeInWithDuration(0.5),
            SKAction.waitForDuration(duration),
            SKAction.fadeOutWithDuration(0.5)
            ])
    }
    
    public class func disappear(delay: NSTimeInterval = 0, duration: NSTimeInterval = -1) -> SKAction {
        var queue = [SKAction]()
        
        if delay > 0 {
            queue.append(SKAction.waitForDuration(delay))
        }
        
        queue.append(SKAction.fadeOutWithDuration(0.5))
        
        if duration > 0 {
            queue.append(SKAction.waitForDuration(duration))
            queue.append(SKAction.fadeInWithDuration(0.5))
        }
        
        return SKAction.sequence(queue)
    }
    
    
    public class func blink(appearTime: NSTimeInterval, disappearTime: NSTimeInterval) -> SKAction {
        return SKAction.repeatActionForever(SKAction.sequence([
            SKAction.waitForDuration(appearTime),
            SKAction.fadeOutWithDuration(0.3),
            SKAction.waitForDuration(disappearTime),
            SKAction.fadeInWithDuration(0.3)
            ]))
    }
}
