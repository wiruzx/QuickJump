//
//  DVTSourceTextView.swift
//  QuickJump
//
//  Created by Victor Shamanov on 5/28/15.
//  Copyright (c) 2015 Victor Shamanov. All rights reserved.
//

import Foundation

extension DVTSourceTextView {
    
    static var activeEditorView: DVTSourceTextView? {
        let windowController = NSApplication.shared().keyWindow?.windowController as? IDEWorkspaceWindowController
        let editor = windowController?.editorArea?.lastActiveEditorContext?.editor
        return editor?.mainScrollView?.contentView.documentView as? DVTSourceTextView
    }
    
    var visibleTextRange: NSRange {
        
        if let clipView = superview as? NSClipView,
           let layoutManager = layoutManager,
           let textContainer = textContainer {
            
            let glyphRange = layoutManager.glyphRange(forBoundingRect: clipView.documentVisibleRect,
                                                                     in: textContainer)
            
            return layoutManager.characterRange(forGlyphRange: glyphRange, actualGlyphRange: nil)
            
        } else {
            fatalError("Unhandled error")
        }
    }
    
    var sourceCode: String {
        return textStorage!.string
    }
    
    func rangesOfVisible(_ char: Character) -> [NSRange] {
        return sourceCode.allRangesOfCharacters(char, inRange: visibleTextRange)
    }
    
    func rangesOfBeginingWords(_ char: Character) -> [NSRange] {
        return sourceCode.allRangesOfCharacterInBeginigOfWord(char, inRange: visibleTextRange)
    }
    
    func rangesOfBeginingsOfTheLines() -> [NSRange] {
        return sourceCode.allRangesOfBeginingsOfTheLinesInRange(visibleTextRange)
    }
    
    func widthOfFirstNonEmptyChar(_ location: Int = 0) -> CGFloat {
        let width = firstRect(forCharacterRange: NSMakeRange(location, 1), actualRange: nil).width
        
        if width > 0 {
            return width
        } else if location > 999 {
            return 0
        } else {
            return widthOfFirstNonEmptyChar(location + 1)
        }
    }
    
    func rectFromRange(_ range: NSRange) -> NSRect {
        
        var rect = firstRect(forCharacterRange: range, actualRange: nil)
        
        if rect.width == 0 {
            rect.size.width = widthOfFirstNonEmptyChar()
        }
        
        let rectInWindow = window!.convertFromScreen(rect)
        var rectInView = self.convert(rectInWindow, from: nil)
        
        let expandSize: CGFloat = 2
        
        rectInView.size.width += expandSize
        rectInView.origin.x -= expandSize / 2
        
        return rectInView
    }
    
}
