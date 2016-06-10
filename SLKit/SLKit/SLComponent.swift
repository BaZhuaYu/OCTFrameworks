//
//  SLComponent.swift
//  SLKit
//
//  Created by yuhan zhang on 4/25/16.
//  Copyright © 2016 octopus. All rights reserved.
//

import Foundation

public class SLComponent: NSObject {
    
    public weak var entity: SLEntity?
    
    
    public func willAddToEntity(entity: SLEntity) {
        
    }
    
    public func didAddToEntity(entity: SLEntity) {
        
    }
    
    public func willRemoveFromEntity(entity: SLEntity) {
        
    }
    
    public func didRemoveFromEntity(entity: SLEntity) {
        
    }
    
    public func updateWithDeltaTime(second: NSTimeInterval) {
        
    }
    
}