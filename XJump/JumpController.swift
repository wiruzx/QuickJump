//
//  JumpController.swift
//  XJump
//
//  Created by Victor Shamanov on 5/28/15.
//  Copyright (c) 2015 Victor Shamanov. All rights reserved.
//

import Foundation

final class JumpController: SingleCharTextFieldDelegate {
    
    // MARK:- Private properties
    
    private let xcodeManager = XCodeManager.sharedManager
    
    private var labelsController: CandidateLabelsController!
    
    private var currentEditorView: DVTSourceTextView! {
        didSet {
            if currentEditorView != oldValue {
                labelsController = CandidateLabelsController(superview: currentEditorView)
            }
        }
    }
    
    private let inputTextField = SingleCharTextField()
    
    // MARK:- Instantiation
    
    init() {
        inputTextField.charInputDelegate = self
    }
    
    // MARK:- Internal methods
    
    func toggle() {
        
        currentEditorView = xcodeManager.currentEditorView
        
        if currentEditorView == nil {
            return
        }
        
        showTextField()
    }
    
    // MARK:- Private methods
    
    private func showTextField() {
        
        let textFieldSize = NSSize(width: 20, height: 20)
        let textFieldRect = NSRect(origin: currentEditorView.cursorPosition, size: textFieldSize)
        
        inputTextField.frame = textFieldRect
        
        currentEditorView.addSubview(inputTextField)
        
        inputTextField.becomeFirstResponder()
    }
    
    private func hideTextField() {
        inputTextField.removeFromSuperview()
    }
    
    private func showResults(char: Character) {
        let ranges = currentEditorView.rangesOfVisible(char)
        let rects = ranges.map(currentEditorView.rectFromRange)
        
        labelsController!.initialize(Array(zip(ranges, rects)))
    }
    
    // MARK:- SingleCharTextFieldDelegate
    
    func didRecieveChar(textField: SingleCharTextField, char: Character) {
        hideTextField()
        showResults(char)
    }
    
}