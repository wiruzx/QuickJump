//
//  CandidateLabelFactory.swift
//  QuickJump
//
//  Created by Victor Shamanov on 6/1/15.
//  Copyright (c) 2015 Victor Shamanov. All rights reserved.
//

import Foundation

final class CandidateLabelFactory {
    
    func labelWithFrame(frame: NSRect, char: Character) -> CandidateLabelType {
        let textView = NSTextView(frame: frame)
        textView.string = String(char)
        textView.backgroundColor = NSColor.grayColor().colorWithAlphaComponent(0.9)
        textView.textColor = .whiteColor()
        textView.textContainerInset = NSSize(width: -3.5, height: 0)
        textView.font = NSFont(name: "Menlo-Regular", size: 12)
        return textView
    }
    
}
