//
//  Alphabet.swift
//  QuickJump
//
//  Created by Victor Shamanov on 6/5/15.
//  Copyright (c) 2015 Victor Shamanov. All rights reserved.
//

import Foundation

struct Alphabet: Encodable, Decodable {
    
    // MARK:- Properties
    
    let chars: [Character]
    
    // MARK:- Instantiation
    
    init(_ string: String, addUppercase: Bool = false) {
        if addUppercase {
            chars = Array(string.lowercaseString + string.uppercaseString)
        } else {
            chars = Array(string)
        }
    }
    
    // MARK:- Encodable
    
    func encode() -> NSDictionaryLikeType {
        return ["string": String(chars)]
    }
    
    // MARK:- Decodable
    
    static func decode(dictionary: NSDictionaryLikeType) -> Alphabet? {
        return map(dictionary["string"] as? String) { Alphabet($0) }
    }
    
    // MARK:- Constants
    
    static let DefaultAlphabet = LatinWithUppercase
    
    static let LatinWithUppercase = Alphabet(LatinAlphabet, addUppercase: true)
    static let Latin = Alphabet(LatinAlphabet)
    
}

func == (lhs: Alphabet, rhs: Alphabet) -> Bool {
    return lhs.chars == rhs.chars
}

private let LatinAlphabet = "abcdefghijklmnopqrstuvwxyz"

struct AlphabetKey: KeyType {
    typealias EntityType = Alphabet
    let key = "alphabet"
}
