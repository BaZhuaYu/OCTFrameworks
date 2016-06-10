//
//  OCT+SKSpriteNode.swift
//  MyGame
//
//  Created by yuhan zhang on 4/5/16.
//  Copyright © 2016 octopus. All rights reserved.
//

import SpriteKit


extension SKSpriteNode {
    public func atMidTop() -> SKSpriteNode {
        return self.atMidX().atTop()
    }
    
    public func atMidBottom() -> SKSpriteNode {
        return self.atMidX().atBottm()
    }
    
    public func atLeftBottom() -> SKSpriteNode {
        return self.atLeft().atBottm()
    }
    
    public func atRightBottom() -> SKSpriteNode {
        return self.atRight().atBottm()
    }
    
    
    public func randomPosition(inRect rect: CGRect) {
        self.randomX(rect.origin.x, to: rect.origin.x + rect.size.width).randomY(rect.origin.y + rect.origin.y + rect.size.height)
    }
    
    
    public func randomX(from: CGFloat = 0, to: CGFloat = OCTScreenWidth) -> SKSpriteNode {
        self.position.x = CGFloat.random(from: from, range: to)
        return self
    }
    
    public func randomY(from: CGFloat = 0, to: CGFloat = OCTScreenHeight) -> SKSpriteNode {
        self.position.y = CGFloat.random(from: from, range: to)
        return self
    }
    
    
    
    
    
    //MARK:- Private
    
    
    private func atMidX() -> SKSpriteNode {
        self.position.x = OCTScreenWidth/2
        return self
    }
    
    private func atMidY() -> SKSpriteNode {
        self.position.y = OCTScreenHeight/2
        return self
    }
    
    private func atBottm() -> SKSpriteNode {
        self.position.y = self.size.height/2
        return self
    }
    
    private func atTop() -> SKSpriteNode {
        self.position.y = OCTScreenHeight - self.size.height/2
        return self
    }
    
    private func atLeft() -> SKSpriteNode {
        self.position.x = self.size.width/2
        return self
    }
    
    private func atRight() -> SKSpriteNode {
        self.position.x = OCTScreenWidth - self.size.width/2
        return self
    }
    
    
    
}







