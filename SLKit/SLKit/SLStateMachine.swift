//
//  SLStateMachine.swift
//  SLKit
//
//  Created by yuhan zhang on 4/25/16.
//  Copyright © 2016 octopus. All rights reserved.
//

import Foundation


public class SLStateMachine: NSObject {
    
    public var currentState: SLState?
    
    private var states = [SLState]()
    
    public init(states: [SLState]) {
        self.states = states
        super.init()
    }
    
    
    public func canEnterStates(stateClass: AnyClass) -> Bool {
        return true
    }
    
    
    public func enterState(stateClass: SLState.Type) -> Bool {
        //        self.currentState = stateForClass(stateClass.dynamicType)
        
        if currentState != nil {
            currentState!.willExitWithNextState(self.stateForClass(stateClass)!)
        }
        
        
        if canEnterStates(stateClass) {
            let prevState = currentState
            self.currentState = stateForClass(stateClass)
            
            currentState?.didEnterWithPreviousState(prevState)
            
            return true
        }
        
        return false
    }
    
    
    public func updateWithDeltaTime(second: NSTimeInterval) {
        self.currentState?.updateWithDeltaTime(second)
    }
    
    
    
    public func stateForClass<state: SLState>(stateClass: state.Type) -> state? {
        for com in self.states {
            if com.classForCoder == stateClass {
                return com as? state
            }
        }
        return nil
    }
    
}
