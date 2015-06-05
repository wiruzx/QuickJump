//
//  Candidate.swift
//  QuickJump 
//
//  Created by Victor Shamanov on 5/29/15.
//  Copyright (c) 2015 Victor Shamanov. All rights reserved.
//

import Foundation

struct Candidate {
    let char: Character
    var next: () -> Candidate?
    
    private static func createStatic(char: Character) -> Candidate {
        return create(char, const(nil))
    }
    
    private static func create(char: Character, _ next: () -> Candidate?) -> Candidate {
        return Candidate(char: char, next: next)
    }
    
    private static func createFromArray(array: [Character]) -> Candidate? {
        if let (head, tail) = array.decomposed {
            var head = Candidate.createStatic(head)
            
            for char in tail {
                head = Candidate.create(char, const(head))
            }
            
            return head
        } else {
            return nil
        }
    }
    
}

private func incIndexes(capacity: Int)(_ indexes: [Int]) -> [Int] {
    if let (head, tail) = indexes.decomposed {
        if head >= capacity - 1 {
            return [0] + incIndexes(capacity)(tail)
        } else {
            return [head + 1] + tail
        }
    } else {
        return [0]
    }
}

private func candidates(alphabet: [Character]) -> SequenceOf<Candidate> {
    let incf = incIndexes(alphabet.count)
    var current = [Int]()
    return SequenceOf(GeneratorOf {
        current = incf(current)
        let letters = current.map { alphabet[$0] }
        return Candidate.createFromArray(letters)
    })
}

func candidatesForCount(alphabet: [Character])(_ count: Int) -> SequenceOf<Candidate> {
    return skip(count / alphabet.count)(candidates(alphabet))
}
