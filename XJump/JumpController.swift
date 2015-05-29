//
//  JumpController.swift
//  XJump
//
//  Created by Victor Shamanov on 5/28/15.
//  Copyright (c) 2015 Victor Shamanov. All rights reserved.
//

import Foundation

final class JumpController: SingleCharTextFieldDelegate {
    
    // MARK:- Type declarations
    
    private enum State {
        case Inactive
        case InputChar
        case ShowResults
    }
    
    // MARK:- Private properties
    
    private let xcodeManager = XCodeManager.sharedManager
    
    private let inputTextField = SingleCharTextField()
    private var state = State.Inactive
    private var labelsController: CandidateLabelsController?
    
    // MARK:- Instantiation
    
    init() {
        inputTextField.charInputDelegate = self
    }
    
    // MARK:- Internal methods
    
    func toggle() {
        showTextField()
    }
    
    // MARK:- Private methods
    
    private func showTextField() {
        
        if let editorView = xcodeManager.currentEditorView {
            
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
        if let editorView = xcodeManager.currentEditorView {
            if labelsController == nil {
                labelsController = CandidateLabelsController(superview: editorView)
            }
            
            let ranges = editorView.rangesOfVisible(char)
            let rects = ranges.map(editorView.rectFromRange)
            
            labelsController!.initialize(Array(zip(ranges, rects)))
        }
    }
    
    // MARK:- SingleCharTextFieldDelegate
    
    func didRecieveChar(textField: SingleCharTextField, char: Character) {
        hideTextField()
        showResults(char)
    }
    
}