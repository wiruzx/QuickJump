//
//  JumpController.swift
//  XJump
//
//  Created by Victor Shamanov on 5/26/15.
//  Copyright (c) 2015 Victor Shamanov. All rights reserved.
//

import AppKit

final class JumpController {
    
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
    
    private lazy var inputTextField = NSTextField()
    
    private var state = State.Inactive
    
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
            
            let success = inputTextField.becomeFirstResponder()
        }
    }
    
    private func hideTextField() {
        inputTextField.removeFromSuperview()
    }
    
}
