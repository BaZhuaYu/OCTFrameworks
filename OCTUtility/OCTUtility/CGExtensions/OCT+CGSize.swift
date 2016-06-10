//
//  OCT+CGSize.swift
//  ZhaiClans
//
//  Created by yuhan zhang on 2/19/16.
//  Copyright © 2016 Octopus. All rights reserved.
//

import UIKit


public func +(a: CGSize, b: CGSize) -> CGSize {
    return CGSize(width: a.width + b.width, height: a.height + b.height)
}


public func *(size: CGSize, factor: CGFloat) -> CGSize {
    return CGSize(width: size.width * factor, height: size.height * factor)
}
