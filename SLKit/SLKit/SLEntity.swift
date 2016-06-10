//
//  SLEntity.swift
//  SLKit
//
//  Created by yuhan zhang on 4/25/16.
//  Copyright © 2016 octopus. All rights reserved.
//

import SpriteKit


public class SLEntity: NSObject {
    
    
    public var components = [SLComponent]()
    
    
    public func addComponent(component: SLComponent) {
        component.willAddToEntity(self)
        self.components.append(component)
        component.entity = self
        component.didAddToEntity(self)
    }
    
    
    public func removeComponent(componentClass: SLComponent.Type) {
        
        self.components = components.filter() {
            if $0.classForCoder == componentClass {
                $0.willRemoveFromEntity(self)
                return false
            }
            return true
        }
        
    }
    
    
    public func componentForClass<componentType: SLComponent>(componentClass: componentType.Type) -> componentType? {
        for com in self.components {
            if let ret = com as? componentType {
                return ret
            }
        }
        return nil
    }
    
    
    public func hasComponent<componentType: SLComponent>(componentClass: componentType.Type) -> Bool {
        return (self.componentForClass(componentClass) != nil)
    }
    
    
    public func updateWithDeltaTime(second: NSTimeInterval) {
        for component in self.components {
            component.updateWithDeltaTime(second)
        }
    }
}


