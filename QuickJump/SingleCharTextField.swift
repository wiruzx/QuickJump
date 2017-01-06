//
//  SingleCharTextField.swift
//  QuickJump
//
//  Created by Victor Shamanov on 5/28/15.
//  Copyright (c) 2015 Victor Shamanov. All rights reserved.
//

import AppKit

protocol SingleCharTextFieldDelegate: class {
    func didRecieveChar(_ textField: SingleCharTextField, char: Character)
    func didLoseFocus(_ textField: SingleCharTextField)
}

final class SingleCharTextField: NSTextField, NSTextFieldDelegate {
    
    // MARK:- Public properties
    
    weak var charInputDelegate: SingleCharTextFieldDelegate?
    
    var forceEnglishKeyboard = false
    
    // MARK:- Instantiation
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: NSRect) {
        super.init(frame: frame)
        delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- NSTextFieldDelegate
    
    func control(_ control: NSControl, textView: NSTextView, doCommandBy commandSelector: Selector) -> Bool {
        switch commandSelector {
        case #selector(complete):
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
            NSTextInputContext.current()?.selectedKeyboardInputSource = "com.apple.keylayout.US"
        }
        return result
    }
    
    override func controlTextDidEndEditing(_ obj: Notification) {
        charInputDelegate?.didLoseFocus(self)
        stringValue = ""
    }
    
    override func textDidChange(_: Notification) {
        if let char = stringValue.characters.last {
            charInputDelegate?.didRecieveChar(self, char: char)
            stringValue = ""
        }
    }
    
}
