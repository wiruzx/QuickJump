//
//  CandidateLabelFactory.swift
//  QuickJump
//
//  Created by Victor Shamanov on 6/1/15.
//  Copyright (c) 2015 Victor Shamanov. All rights reserved.
//

import Foundation

final class CandidateLabelFactory {
    
    // MARK:- Private properties
    
    private let defaultFont = NSFont(name: "Menlo-Regular", size: 12)!
    
    private var currentFont: NSFont {
        return (DVTFontAndColorTheme.currentTheme() as? DVTFontAndColorTheme)?.sourcePlainTextFont ?? defaultFont
    }
    
    // MARK:- Public methods
    
    func label(frame: NSRect, char: Character) -> CandidateLabelType {
        return CandidateTextView(frame: frame, font: currentFont, string: String(char))
    }
    
}
