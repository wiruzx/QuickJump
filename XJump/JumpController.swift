//
//  JumpController.swift
//  XJump
//
//  Created by Victor Shamanov on 5/26/15.
//  Copyright (c) 2015 Victor Shamanov. All rights reserved.
//

import AppKit

final class JumpController: SingleCharTextFieldDelegate {
    
    // MARK:- Type declarations
    
    private enum State {
        case Inactive
        case InputChar
        case ShowResults
    }
    
    // MARK:- Private properties
    
    private var currentEditorView: DVTSourceTextView? {
        let windowController = NSApplication.sharedApplication().keyWindow?.windowController() as? IDEWorkspaceWindowController
        let editor = windowController?.editorArea?.lastActiveEditorContext?.editor
        return editor?.mainScrollView?.contentView.documentView as? DVTSourceTextView
    }
    
    private let inputTextField = SingleCharTextField()
    private var state = State.Inactive
    
    // MARK:- Instantiation
    
    init() {
        inputTextField.charInputDelegate = self
    }
    
    // MARK:- Internal methods
    
    func toggle() {
        
    }
    
    // MARK:- Private methods
    
    private func showTextField() {
        
        if let editorView = currentEditorView {
            
            let textFieldSize = NSSize(width: 20, height: 20)
            let textFieldRect = NSRect(origin: editorView.cursorPosition, size: textFieldSize)
            
            inputTextField.frame = textFieldRect
            
            editorView.addSubview(inputTextField)
            
            if inputTextField.becomeFirstResponder() {
                state = .InputChar
            } else {
                state = .Inactive
                hideTextField()
            }
        }
    }
    
    private func hideTextField() {
        inputTextField.removeFromSuperview()
    }
    
    private func showResults(char: Character) {
        state = .ShowResults
        
    }
    
    // MARK:- SingleCharTextFieldDelegate
    
    func didRecieveChar(textField: SingleCharTextField, char: Character) {
        hideTextField()
        showResults(char)
    }
    
}
