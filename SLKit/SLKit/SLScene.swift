////
////  SLScene.swift
////  SLKit
////
////  Created by yuhan zhang on 4/25/16.
////  Copyright © 2016 octopus. All rights reserved.
////
//
//import SpriteKit
//
//class SLScene: SKScene {
//    
//    var gameStateMachine: SLStateMachine?
//    
//    var entities = [SLEntity]()
//    
//    
//    var previousTime: NSTimeInterval = -0.2
//    
//    var currentTime: NSTimeInterval = 0
//    
//    var deltaTime: NSTimeInterval {
//        return self.currentTime - self.previousTime
//    }
//    
//    
//    override func didMoveToView(view: SKView) {
//        self.backgroundColor = SKColor.blackColor()
//        self.scaleMode = .AspectFit
//    }
//    
//    
//    override func update(currentTime: NSTimeInterval) {
//        self.currentTime = currentTime
//        
//        for entity in self.entities {
//            entity.updateWithDeltaTime(deltaTime)
//        }
//        
//        self.gameStateMachine?.updateWithDeltaTime(deltaTime)
//    }
//    
//    
//    override func didFinishUpdate() {
//        self.previousTime = self.currentTime
//    }
//    
//    
//    func addEntity(entity: SLEntity) {
//        self.entities.append(entity)
//        
//        if let node = entity.componentForClass(SpriteComponent.self)?.sprite {
//            self.addChild(node)
//        }
//    }
//    
//    
//}
//
