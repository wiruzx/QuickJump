//
//  StringUtils.swift
//  QuickJump
//
//  Created by Victor Shamanov on 5/28/15.
//  Copyright (c) 2015 Victor Shamanov. All rights reserved.
//

import Foundation

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
    
    func allRangesOfCharacterInBeginigOfWord(char: Character, inRange: NSRange) -> [NSRange] {
        
        let string = self as NSString
        
        var result = [NSRange]()
        
        string.enumerateSubstringsInRange(inRange, options: .ByWords) { substr, range, _, _ in
            if first(substr) == char {
                var firstCharRange = range
                firstCharRange.length = 1
                result.append(firstCharRange)
            }
        }
        
        return result
    }
    
}
