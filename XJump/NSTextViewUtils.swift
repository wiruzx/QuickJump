//
//  NSTextViewUtils.swift
//  XJump
//
//  Created by Victor Shamanov on 5/27/15.
//  Copyright (c) 2015 Victor Shamanov. All rights reserved.
//

import AppKit

private let defaultCursorPoint: NSPoint = .zeroPoint

extension NSTextView {
    
    var cursorPosition: NSPoint {
        
        if let range = selectedRanges.first?.rangeValue,
           let layoutManager = layoutManager,
           let textContainer = textContainer {
            
            let glyphRange = layoutManager.glyphRangeForCharacterRange(range, actualCharacterRange: nil)
            let rect = layoutManager.boundingRectForGlyphRange(glyphRange, inTextContainer: textContainer)

            let rectWithOffset = NSOffsetRect(rect, textContainerOrigin.x, textContainerOrigin.y)
            
            return rectWithOffset.origin
        } else {
            return defaultCursorPoint
        }
    }
}
