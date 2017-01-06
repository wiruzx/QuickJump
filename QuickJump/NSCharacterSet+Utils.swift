//
//  NSCharacterSet+Utils.swift
//  QuickJump
//
//  Created by Victor Shamanov on 9/3/15.
//  Copyright (c) 2015 Victor Shamanov. All rights reserved.
//

import Foundation

extension CharacterSet {
    
    func contains(_ character: Character) -> Bool {
        let set = CharacterSet(charactersIn: String(character))
        return isSuperset(of: set)
    }
    
}

func + (lhs: CharacterSet, rhs: CharacterSet) -> CharacterSet {
    let mutable = (lhs as NSCharacterSet).mutableCopy() as! NSMutableCharacterSet
    mutable.formUnion(with: rhs)
    return mutable.copy() as! CharacterSet
}
