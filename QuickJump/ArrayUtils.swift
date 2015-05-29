//
//  ArrayUtils.swift
//  QuickJump
//
//  Created by Victor Shamanov on 5/29/15.
//  Copyright (c) 2015 Victor Shamanov. All rights reserved.
//

import Foundation

extension Array {
    func each(f: T -> Void)  {
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
