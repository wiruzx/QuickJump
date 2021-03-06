//
//  NSTextViewUtils.swift
//  QuickJump
//
//  Created by Victor Shamanov on 5/27/15.
//  Copyright (c) 2015 Victor Shamanov. All rights reserved.
//

import AppKit

private let defaultCursorPoint: NSPoint = .zero

extension NSTextView {
    
    var cursorPosition: NSPoint {
        
        if let range = selectedRanges.first?.rangeValue,
           let layoutManager = layoutManager,
           let textContainer = textContainer {
            
            let glyphRange = layoutManager.glyphRange(forCharacterRange: range, actualCharacterRange: nil)
            let rect = layoutManager.boundingRect(forGlyphRange: glyphRange, in: textContainer)

            let rectWithOffset = NSOffsetRect(rect, textContainerOrigin.x, textContainerOrigin.y)
            
            return rectWithOffset.origin
        } else {
            return defaultCursorPoint
        }
    }
}
