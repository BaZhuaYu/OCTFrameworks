//
//  Logger.swift
//  ZhaiClans
//
//  Created by yuhan zhang on 12/1/15.
//  Copyright © 2015 Octopus. All rights reserved.
//

import Foundation

public extension String {
    public mutating func removeLastCharacter(count: Int = 1) {
        self = self.substringToIndex(self.endIndex.advancedBy(-count))
    }
}