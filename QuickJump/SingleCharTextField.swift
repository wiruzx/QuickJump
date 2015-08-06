//
//  SingleCharTextField.swift
//  QuickJump
//
//  Created by Victor Shamanov on 5/28/15.
//  Copyright (c) 2015 Victor Shamanov. All rights reserved.
//

import AppKit

protocol SingleCharTextFieldDelegate: class {
    func didRecieveChar(textField: SingleCharTextField, char: Character)
    func didLoseFocus(textField: SingleCharTextField)
}

final class SingleCharTextField: NSTextField, NSTextFieldDelegate {
    
    // MARK:- Public properties
    
    weak var charInputDelegate: SingleCharTextFieldDelegate?
    
    var forceEnglishKeyboard = false
    
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
    
    // MARK:- NSTextFieldDelegate
    
    func control(control: NSControl, textView: NSTextView, doCommandBySelector commandSelector: Selector) -> Bool {
        switch commandSelector {
        case "complete:":
            charInputDelegate?.didLoseFocus(self)
            return true
        default:
            return false
        }
    }
    
    // MARK:- Overriden methods
    
    override func becomeFirstResponder() -> Bool {
        let result = super.becomeFirstResponder()
        if forceEnglishKeyboard {
            NSTextInputContext.currentInputContext()?.selectedKeyboardInputSource = "com.apple.keylayout.US"
        }
        return result
    }
    
    override func controlTextDidEndEditing(obj: NSNotification) {
        charInputDelegate?.didLoseFocus(self)
        stringValue = ""
    }
    
    override func textDidChange(_: NSNotification) {
        if let char = last(stringValue) {
            charInputDelegate?.didRecieveChar(self, char: char)
            stringValue = ""
        }
    }
    
}
