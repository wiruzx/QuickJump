//
//  IndexesSequence.swift
//  QuickJump
//
//  Created by Victor Shamanov on 28.05.16.
//  Copyright © 2016 Victor Shamanov. All rights reserved.
//

struct IndexesSequence: Sequence {
    
    private let capacity: Int
    
    init(capacity: Int) {
        self.capacity = capacity
    }
    
    func makeIterator() -> AnyIterator<[Int]> {
        
        var current = [0]
        
        return AnyIterator { [capacity] in
            
            if current[0] >= capacity - 1 {
                current.insert(0, at: 0)
            } else {
                current[0] += 1
            }
            
            return current
        }
    }
}
