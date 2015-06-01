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
        let textField = NSTextField(frame: frame)
        textField.stringValue = String(char)
        return textField
    }
    
}
