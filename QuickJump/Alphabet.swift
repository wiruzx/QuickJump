//
//  Alphabet.swift
//  QuickJump
//
//  Created by Victor Shamanov on 6/5/15.
//  Copyright (c) 2015 Victor Shamanov. All rights reserved.
//

struct Alphabet {
    
    // MARK:- Properties
    
    let chars: [Character]
    
    // MARK:- Instantiation
    
    init(_ string: String, addUppercase: Bool = false) {
        if addUppercase {
            chars = Array((string.lowercaseString + string.uppercaseString).characters)
        } else {
            chars = Array(string.characters)
        }
    }
    
    // MARK: - Public Constants
    
    static let DefaultAlphabet = LatinWithUppercase
    
    static let LatinWithUppercase = Alphabet(LatinAlphabet, addUppercase: true)
    static let Latin = Alphabet(LatinAlphabet)
    
}

// MARK: - Constants

private let LatinAlphabet = "abcdefghijklmnopqrstuvwxyz"

// MARK: - Equatable

func == (lhs: Alphabet, rhs: Alphabet) -> Bool {
    return lhs.chars == rhs.chars
}

// MARK: - Conding

extension Alphabet: Encodable, Decodable {
    
    func encode() -> [String: AnyObject] {
        return ["string": String(chars)]
    }
    
    init?(dictionary: [String: AnyObject]) {
        guard let value = dictionary["string"] as? String else { return nil }
        self.init(value)
    }
}
