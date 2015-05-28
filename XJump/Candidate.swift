//
//  Candidate.swift
//  XJump
//
//  Created by Victor Shamanov on 5/29/15.
//  Copyright (c) 2015 Victor Shamanov. All rights reserved.
//

import Foundation

private let lowercase = "abcdefghijklmnopqrstuvwxyz"
private let uppercase = lowercase.uppercaseString
private let alphabet = lowercase + uppercase

struct Candidate {
    let char: Character
    let next: () -> Candidate?
    
    private static func create(char: Character) -> Candidate {
        return Candidate(char: char) { nil }
    }
}

func candidates(count: Int) -> [Candidate] {
    if count <= alphabet.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) {
        return map(alphabet, Candidate.create)
    } else {
        return []
    }
}
