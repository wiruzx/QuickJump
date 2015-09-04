//
//  NSCharacterSet+Utils.swift
//  QuickJump
//
//  Created by Victor Shamanov on 9/3/15.
//  Copyright (c) 2015 Victor Shamanov. All rights reserved.
//

import Foundation

extension NSCharacterSet {
    
    func characterIsMember(character: Character) -> Bool {
        let set = NSCharacterSet(charactersInString: String(character))
        return isSupersetOfSet(set)
    }
    
}

func + (lhs: NSCharacterSet, rhs: NSCharacterSet) -> NSCharacterSet {
    let mutable = lhs.mutableCopy() as! NSMutableCharacterSet
    mutable.formUnionWithCharacterSet(rhs)
    return mutable.copy() as! NSCharacterSet
}
