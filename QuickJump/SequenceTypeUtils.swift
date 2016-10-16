//
//  SequenceTypeUtils.swift
//  QuickJump
//
//  Created by Victor Shamanov on 6/1/15.
//  Copyright (c) 2015 Victor Shamanov. All rights reserved.
//

import Foundation

extension Sequence {
    
    func find(_ predicate: (Iterator.Element) -> Bool) -> Iterator.Element? {
        
        for x in self where predicate(x) {
            return x
        }
        
        return nil
    }
    
}
