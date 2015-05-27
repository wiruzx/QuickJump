//
//  Candidates.swift
//  XJump
//
//  Created by Victor Shamanov on 5/28/15.
//  Copyright (c) 2015 Victor Shamanov. All rights reserved.
//

import Foundation

private let lowercase = "abcdefghijklmnopqrstuvwxyz"
private let uppercase = lowercase.uppercaseString
private let alphabet = lowercase + uppercase

private func sequenceOfOne<T>(value: T) -> SequenceOf<T> {
    return SequenceOf(GeneratorOfOne(value))
}

func candidates(count: Int) -> [SequenceOf<Character>] {
    if count <= alphabet.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) {
        return map(alphabet, sequenceOfOne)
    } else {
        fatalError("Not implemented yet")
    }
}
