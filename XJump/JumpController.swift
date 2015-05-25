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
        if let rect = (currentEditorView?.superview as? NSClipView)?.documentVisibleRect {
            
            var textFieldRect = rect
            textFieldRect.origin.y += rect.size.height - 25
            textFieldRect.size = NSSize(width: 100, height: 100)
            
            inputTextField.frame = textFieldRect
            
            currentEditorView!.addSubview(inputTextField)
            
            inputTextField.window?.makeFirstResponder(inputTextField)
        }
    }
    
    private func hideTextField() {
        inputTextField.removeFromSuperview()
    }
}
