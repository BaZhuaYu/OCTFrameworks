//
//  SLState.swift
//  SLKit
//
//  Created by yuhan zhang on 4/25/16.
//  Copyright © 2016 octopus. All rights reserved.
//

import Foundation


public class SLState: NSObject {
    
    public weak var stateMachine: SLStateMachine?
    
    
    public func isValidNextState(stateClass: AnyClass) -> Bool {
        return true
    }
    
    
    public func didEnterWithPreviousState(previousState: SLState?) {
        
    }
    
    
    public func willExitWithNextState(nextState: SLState) {
        
    }
    
    
    public func updateWithDeltaTime(second: NSTimeInterval) {
        
    }
    
}
