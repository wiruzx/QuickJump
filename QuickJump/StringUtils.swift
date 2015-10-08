//
//  StringUtils.swift
//  QuickJump
//
//  Created by Victor Shamanov on 5/28/15.
//  Copyright (c) 2015 Victor Shamanov. All rights reserved.
//

import Foundation

private let letters = NSCharacterSet.letterCharacterSet()
private let punctuation: NSCharacterSet = .punctuationCharacterSet() + .whitespaceAndNewlineCharacterSet()

extension String {
    
    func allRangesOfCharacters(char: Character, inRange: NSRange) -> [NSRange] {
        let string: NSString = self
        let charAsString = String(char)
        
        var result = [NSRange]()
        
        string.enumerateSubstringsInRange(inRange, options: .ByComposedCharacterSequences) { substr, range, _, _ in
            if substr == charAsString {
                result.append(range)
            }
        }
        
        return result
    }
    
    func allRangesOfCharacterInBeginigOfWord(char: Character, inRange range: NSRange) -> [NSRange] {
        
        if !letters.characterIsMember(char) {
            return allRangesOfCharacters(char, inRange: range)
        }
        
        var result = [NSRange]()
        var previousChar: Character?
        
        (self as NSString).enumerateSubstringsInRange(range, options: .ByComposedCharacterSequences) { substr, range, _, _ in
            let foundChar = substr?.characters.first!

            if foundChar == char {
                if let prev = previousChar {
                    if punctuation.characterIsMember(prev) {
                        result.append(range)
                    }
                } else {
                    result.append(range)
                }
            }
            
            previousChar = foundChar
        }
        
        return result
    }
    
    func allRangesOfBeginingsOfTheLinesInRange(range: NSRange) -> [NSRange] {
        
        var result = [NSRange]()
        
        (self as NSString).enumerateSubstringsInRange(range, options: .ByLines) { substr, range, _, _ in
            var firstCharRange = range
            firstCharRange.length = 1
            result.append(firstCharRange)
        }
        
        return result
    }
    
}
