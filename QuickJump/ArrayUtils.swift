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
    
    func each(@noescape f: Element -> Void)  {
        for x in self {
            f(x)
        }
    }
    
    func findFirst(p: Element -> Bool) -> Element? {
        for x in self {
            if p(x) {
                return x
            }
        }
        
        return nil
    }
    
}
