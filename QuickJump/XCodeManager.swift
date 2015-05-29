//
//  XCodeManager.swift
//  QuickJump
//
//  Created by Victor Shamanov on 5/28/15.
//  Copyright (c) 2015 Victor Shamanov. All rights reserved.
//

import Foundation

final class XCodeManager {
    
    // MARK:- Public properties
    
    var currentEditorView: DVTSourceTextView? {
        let windowController = NSApplication.sharedApplication().keyWindow?.windowController() as? IDEWorkspaceWindowController
        let editor = windowController?.editorArea?.lastActiveEditorContext?.editor
        return editor?.mainScrollView?.contentView.documentView as? DVTSourceTextView
    }
    
    // MARK:- Instantiation
    
    static let sharedManager = XCodeManager()
    
}
