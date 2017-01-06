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
    
    init(string: String, addUppercase: Bool = false) {
        if addUppercase {
            chars = Array((string.lowercased() + string.uppercased()).characters)
        } else {
            chars = Array(string.characters)
        }
    }
    
    // MARK: - Public Constants
    
    static let defaultAlphabet = latinWithUppercase
    
    static let latinWithUppercase = Alphabet(string: latinAlphabet, addUppercase: true)
    static let latin = Alphabet(string: latinAlphabet)
    
}

// MARK: - Constants

private let latinAlphabet = "abcdefghijklmnopqrstuvwxyz"

// MARK: - Equatable

func == (lhs: Alphabet, rhs: Alphabet) -> Bool {
    return lhs.chars == rhs.chars
}

// MARK: - Conding

extension Alphabet: Encodable, Decodable {
    
    func encode() -> [String: AnyObject] {
        return ["string": String(chars) as AnyObject]
    }
    
    init?(dictionary: [String: AnyObject]) {
        guard let value = dictionary["string"] as? String else { return nil }
        self.init(string: value)
    }
}
