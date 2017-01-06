//
//  StringUtils.swift
//  QuickJump
//
//  Created by Victor Shamanov on 5/28/15.
//  Copyright (c) 2015 Victor Shamanov. All rights reserved.
//

import Foundation

private let letters: CharacterSet = .alphanumerics
private let punctuation: CharacterSet = .punctuationCharacters + .whitespacesAndNewlines + .symbols

extension String {
    
    func allRangesOfCharacters(_ char: Character, inRange: NSRange) -> [NSRange] {
        let charAsString = String(char)
        
        var result: [NSRange] = []
        
        (self as NSString).enumerateSubstrings(in: inRange, options: .byComposedCharacterSequences) { substr, range, _, _ in
            
            guard substr == charAsString else { return }
            
            result.append(range)
        }
        
        return result
    }
    
    func allRangesOfCharacterInBeginigOfWord(_ char: Character, inRange range: NSRange) -> [NSRange] {
        
        guard letters.contains(char) else { return allRangesOfCharacters(char, inRange: range) }
        
        var result: [NSRange] = []
        var previousChar: Character?
        
        (self as NSString).enumerateSubstrings(in: range, options: .byComposedCharacterSequences) { substr, range, _, _ in
            let foundChar = substr?.characters.first!

            defer { previousChar = foundChar }
            
            guard foundChar == char else { return }
            guard previousChar != nil else { return result.append(range) }
            guard punctuation.contains(previousChar!) else { return }
            
            result.append(range)
        }
        
        return result
    }
    
    func allRangesOfBeginingsOfTheLinesInRange(_ range: NSRange) -> [NSRange] {
        
        var result: [NSRange] = []
        
        (self as NSString).enumerateSubstrings(in: range, options: NSString.EnumerationOptions()) { substr, range, _, _ in
            var firstCharRange = range
            firstCharRange.length = 1
            result.append(firstCharRange)
        }
        
        return result
    }
    
}
