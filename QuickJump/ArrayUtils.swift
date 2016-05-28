//
//  ArrayUtils.swift
//  QuickJump
//
//  Created by Victor Shamanov on 5/29/15.
//  Copyright (c) 2015 Victor Shamanov. All rights reserved.
//

import Foundation

extension Array {
    
    var decomposed: (Element, [Element])? {
        return isEmpty ? nil : (first!, Array(self.dropFirst()))
    }
    
    func find(p: Element -> Bool) -> Element? {
        for x in self where p(x) {
            return x
        }
        
        return nil
    }
    
}
