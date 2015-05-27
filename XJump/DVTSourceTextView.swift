//
//  DVTSourceTextView.swift
//  XJump
//
//  Created by Victor Shamanov on 5/28/15.
//  Copyright (c) 2015 Victor Shamanov. All rights reserved.
//

import Foundation

extension DVTSourceTextView {
    
    var visibleTextRange: NSRange {
        
        if let clipView = superview as? NSClipView,
           let layoutManager = layoutManager,
           let textContainer = textContainer {
            
            let glyphRange = layoutManager.glyphRangeForBoundingRect(clipView.documentVisibleRect,
                                                                     inTextContainer: textContainer)
            
            return layoutManager.characterRangeForGlyphRange(glyphRange, actualGlyphRange: nil)
            
        } else {
            fatalError("Unhandled error")
        }
    }
    
    func rectsOfChar(char: Character) -> [NSRect] {
        return textStorage?.string.allRangesOfCharacters(char).map(rectFromRange) ?? []
    }
    
    private func rectFromRange(range: NSRange) -> NSRect {
        fatalError("Not implemented yet")
    }
    
}
