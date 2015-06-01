//
//  ArrayUtils.swift
//  QuickJump
//
//  Created by Victor Shamanov on 5/29/15.
//  Copyright (c) 2015 Victor Shamanov. All rights reserved.
//

import Foundation

extension Array {
    
    var decomposed: (T, [T])? {
        return isEmpty ? nil : (first!, Array(dropFirst(self)))
    }
    
    func each(@noescape f: T -> Void)  {
        for x in self {
            f(x)
        }
    }
    
    func findFirst(p: T -> Bool) -> T? {
        for x in self {
            if p(x) {
                return x
            }
        }
        
        return nil
    }
    
}
