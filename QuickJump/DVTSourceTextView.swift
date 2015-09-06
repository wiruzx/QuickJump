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
        let windowController = NSApplication.sharedApplication().keyWindow?.windowController() as? IDEWorkspaceWindowController
        let editor = windowController?.editorArea?.lastActiveEditorContext?.editor
        return editor?.mainScrollView?.contentView.documentView as? DVTSourceTextView
    }
    
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
    
    var sourceCode: String {
        return (textStorage() as! NSTextStorage).string
    }
    
    func rangesOfVisible(char: Character) -> [NSRange] {
        return sourceCode.allRangesOfCharacters(char, inRange: visibleTextRange)
    }
    
    func rangesOfBeginingWords(char: Character) -> [NSRange] {
        return sourceCode.allRangesOfCharacterInBeginigOfWord(char, inRange: visibleTextRange)
    }
    
    func rangesOfBeginingsOfTheLines() -> [NSRange] {
        return sourceCode.allRangesOfBeginingsOfTheLinesInRange(visibleTextRange)
    }
    
    func rectFromRange(range: NSRange) -> NSRect {
        let rect = firstRectForCharacterRange(range, actualRange: nil)
        let rectInWindow = window!.convertRectFromScreen(rect)
        var rectInView = self.convertRect(rectInWindow, fromView: nil)
        
        let expandSize: CGFloat = 2
        
        rectInView.size.width += expandSize
        rectInView.origin.x -= expandSize / 2
        
        return rectInView
    }
    
}
