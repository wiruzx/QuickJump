//
//  SequenceTypeUtils.swift
//  QuickJump
//
//  Created by Victor Shamanov on 6/1/15.
//  Copyright (c) 2015 Victor Shamanov. All rights reserved.
//

import Foundation

extension SequenceType {
    
    func skip(count: Int) -> AnySequence<Generator.Element> {
        
        var generator = generate()
        var count = count
        
        return AnySequence(anyGenerator {
            
            while count > 0 {
                guard let _ = generator.next() else { return nil }
                count -= 1
            }
            
            return generator.next()
        })
    }
    
    func take(count: Int) -> AnySequence<Generator.Element> {
        
        var generator = generate()
        var count = count
        
        return AnySequence(anyGenerator {
            guard count > 0 else { return nil }
            count -= 1
            return generator.next()
        })
    }
    
    func find(@noescape predicate: Generator.Element -> Bool) -> Generator.Element? {
        
        for x in self where predicate(x) {
            return x
        }
        
        return nil
    }
    
}
