//
//  Double+StringCheck.swift
//  EasyGC
//
//  Created by James Feng on 8/24/15.
//  Copyright (c) 2015 James Feng. All rights reserved.
//

import Foundation

extension String {
    var doubleValue:Double? {
        return NSNumberFormatter().numberFromString(self)?.doubleValue
    }
}