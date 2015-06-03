//
//  JumpController.swift
//  QuickJump
//
//  Created by Victor Shamanov on 5/28/15.
//  Copyright (c) 2015 Victor Shamanov. All rights reserved.
//

import Foundation

final class JumpController: SingleCharTextFieldDelegate {
    
    // MARK:- Type declaration
    
    private enum State {
        case Inactive, InputChar, ShowCandidates
    }
    
    // MARK:- Public properties
    
    var caseType = CaseType.Insensitive
    
    // MARK:- Private properties
    
    private var state: State = .Inactive
    
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
        
        currentEditorView = .activeEditorView
        
        if currentEditorView == nil {
            return
        }
        
        state = .InputChar
        showTextField()
    }
    
    // MARK:- Private methods
    
    private func showTextField() {
        
        let textFieldSize = NSSize(width: 20, height: 20)
        let textFieldRect = NSRect(origin: currentEditorView.cursorPosition, size: textFieldSize)
        
        inputTextField.frame = textFieldRect
        inputTextField.alphaValue = 1
        
        currentEditorView.addSubview(inputTextField)
        
        inputTextField.becomeFirstResponder()
    }
    
    private func hideTextField() {
        inputTextField.alphaValue = 0
    }
    
    private func removeTextField() {
        inputTextField.removeFromSuperview()
    }
    
    private func rangesForChar(char: Character) -> [NSRange] {
        if caseType == .Sensitive {
            return currentEditorView.rangesOfVisible(char)
        } else {
            let lowercaseChar = Character(String(char).lowercaseString)
            let uppercaseChar = Character(String(char).uppercaseString)
            
            let charsEqual = lowercaseChar == uppercaseChar
            
            let lowercaseRanges = currentEditorView.rangesOfVisible(lowercaseChar)
            let uppercaseRanges = charsEqual ? [] : currentEditorView.rangesOfVisible(uppercaseChar)
            
            return lowercaseRanges + uppercaseRanges
        }
    }
    
    private func showResults(char: Character) {
        
        let ranges = rangesForChar(char)
        
        let rects = ranges.map(currentEditorView.rectFromRange)
        
        if ranges.isEmpty {
            abort()
            return
        } else if ranges.count == 1 {
            jump(ranges.first!)
            state = .Inactive
            removeTextField()
            return
        }
        
        state = .ShowCandidates
        labelsController.initialize(Array(zip(ranges, rects)))
    }
    
    private func abort() {
        state = .Inactive
        removeTextField()
        labelsController.cancel()
        currentEditorView.window?.makeFirstResponder(currentEditorView)
    }

    private func jump(range: NSRange) {
        currentEditorView.setSelectedRange(range)
        currentEditorView.window?.makeFirstResponder(currentEditorView)
    }
    
    // MARK:- SingleCharTextFieldDelegate
    
    func didRecieveChar(textField: SingleCharTextField, char: Character) {
        switch state {
        case .InputChar:
            hideTextField()
            showResults(char)
        case .ShowCandidates:
            if let result = labelsController.next(char) {
                removeTextField()
                state = .Inactive
                jump(result.range)
            }
        default:
            break
        }
    }
    
    func didLoseFocus(textField: SingleCharTextField) {
        abort()
    }
    
}
