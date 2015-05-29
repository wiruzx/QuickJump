//
//  StringUtils.swift
//  XJump
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
    
}
