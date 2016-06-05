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
        let charAsString = String(char)
        
        var result: [NSRange] = []
        
        (self as NSString).enumerateSubstringsInRange(inRange, options: .ByComposedCharacterSequences) { substr, range, _, _ in
            
            guard substr == charAsString else { return }
            
            result.append(range)
        }
        
        return result
    }
    
    func allRangesOfCharacterInBeginigOfWord(char: Character, inRange range: NSRange) -> [NSRange] {
        
        guard letters.contains(char) else { return allRangesOfCharacters(char, inRange: range) }
        
        var result: [NSRange] = []
        var previousChar: Character?
        
        (self as NSString).enumerateSubstringsInRange(range, options: .ByComposedCharacterSequences) { substr, range, _, _ in
            let foundChar = substr?.characters.first!

            defer { previousChar = foundChar }
            
            guard foundChar == char else { return }
            guard previousChar != nil else { return result.append(range) }
            guard punctuation.contains(previousChar!) else { return }
            
            result.append(range)
        }
        
        return result
    }
    
    func allRangesOfBeginingsOfTheLinesInRange(range: NSRange) -> [NSRange] {
        
        var result: [NSRange] = []
        
        (self as NSString).enumerateSubstringsInRange(range, options: .ByLines) { substr, range, _, _ in
            var firstCharRange = range
            firstCharRange.length = 1
            result.append(firstCharRange)
        }
        
        return result
    }
    
}
