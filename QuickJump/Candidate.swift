//
//  Candidate.swift
//  QuickJump 
//
//  Created by Victor Shamanov on 5/29/15.
//  Copyright (c) 2015 Victor Shamanov. All rights reserved.
//

struct Candidate {
    
    private let array: [Character]
    
    private init(_ array: [Character]) {
        guard let first = array.first else {
            fatalError("Array should not be empty")
        }
        
        self.char = first
        self.array = Array(array.dropFirst())
    }
    
    let char: Character
    
    func next() -> Candidate? {
        return array.isEmpty ? nil : Candidate(array)
    }
}

struct CandidateFactory {
    
    private let alphabet: [Character]
    
    init(alphabet: [Character]) {
        self.alphabet = alphabet
    }
    
    func candidates(count: Int) -> [Candidate] {
        return IndexesSequence(capacity: alphabet.count)
            .skip(count / alphabet.count)
            .take(count)
            .map { .init($0.map { alphabet[$0] }) }
    }
}
