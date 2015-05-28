//
//  SingleCharTextField.swift
//  XJump
//
//  Created by Victor Shamanov on 5/28/15.
//  Copyright (c) 2015 Victor Shamanov. All rights reserved.
//

import AppKit

protocol SingleCharTextFieldDelegate: class {
    func didRecieveChar(textField: SingleCharTextField, char: Character)
}

final class SingleCharTextField: NSTextField, NSTextFieldDelegate {
    
    // MARK:- Public properties
    
    weak var charInputDelegate: SingleCharTextFieldDelegate?
    
    // MARK:- Instantiation
    
    convenience init() {
        self.init(frame: .zeroRect)
    }
    
    override init(frame: NSRect) {
        super.init(frame: frame)
        delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Overriden methods
    
    override func textDidChange(_: NSNotification) {
        if let char = last(stringValue) {
            charInputDelegate?.didRecieveChar(self, char: char)
            stringValue = ""
        }
    }
    
}
