//
//  CandidateTextView.swift
//  QuickJump
//
//  Created by Victor Shamanov on 6/4/15.
//  Copyright (c) 2015 Victor Shamanov. All rights reserved.
//

import AppKit

final class CandidateTextView: NSTextView {
    
    // MARK:- Initialization
    
    convenience init(frame: NSRect, font: NSFont, string: String) {
        self.init(frame: frame)
        
        self.string = string
        backgroundColor = NSColor.darkGrayColor()
        textColor = .whiteColor()
        textContainerInset = NSSize(width: -3.5, height: 0)
        self.font = font
    }
    
    // MARK:- Overriden methods
    
    override func drawRect(dirtyRect: NSRect) {
        let path = NSBezierPath(roundedRect: dirtyRect, xRadius: 2, yRadius: 2)
        path.addClip()
        super.drawRect(dirtyRect)
    }
    
}
