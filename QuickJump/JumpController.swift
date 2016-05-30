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
    
    enum InputMode {
        case Char, Word, Line
    }
    
    private enum State {
        case Inactive, InputChar, ShowCandidates
    }
    
    // MARK:- Public properties
    
    var caseType = CaseType.Insensitive
    var alphabet: [Character]! {
        didSet {
            if let a = alphabet, b = oldValue where a != b {
                initializeLabelController()
            }
        }
    }
    
    var forcedEnglishLayout: Bool {
        get {
            return inputTextField.forceEnglishKeyboard
        }
        set {
            inputTextField.forceEnglishKeyboard = newValue
        }
    }
    
    // MARK:- Private properties
    
    private var inputMode: InputMode = .Char
    
    private var state: State = .Inactive
    
    private var labelsController: CandidateLabelsPresenter!
    
    private var currentEditorView: DVTSourceTextView! {
        didSet {
            if currentEditorView != oldValue {
                initializeLabelController()
            }
        }
    }
    
    private let inputTextField = SingleCharTextField()
    
    // MARK:- Instantiation
    
    init() {
        inputTextField.charInputDelegate = self
    }
    
    // MARK:- Internal methods
    
    func toggle(mode: InputMode) {
        
        self.inputMode = mode
        
        if state == .ShowCandidates {
            abort()
            return
        }

        currentEditorView = .activeEditorView
        
        if currentEditorView == nil {
            return
        }
        
        if mode == .Line {
            state = .ShowCandidates
            showTextField()
            hideTextField()
            showLineCandidates()
        } else {
            state = .InputChar
            showTextField()
        }
    }
    
    // MARK:- Private methods
    
    private func initializeLabelController() {
        
        guard let view = currentEditorView, alphabet = alphabet else { return }
        
        labelsController = CandidateLabelsPresenter(view: view, alphabet: alphabet)
    }
    
    private func showLineCandidates() {
        showResultsForRanges(currentEditorView.rangesOfBeginingsOfTheLines())
    }
    
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
        
        let rangesFn: Character -> [NSRange]
        switch inputMode {
        case .Word:
            rangesFn = currentEditorView.rangesOfBeginingWords
        case .Char:
            rangesFn = currentEditorView.rangesOfVisible
        default:
            fatalError("Unhandled behavior")
        }
        
        if caseType == .Sensitive {
            return rangesFn(char)
        } else {
            let lowercaseChar = Character(String(char).lowercaseString)
            let uppercaseChar = Character(String(char).uppercaseString)
            
            let charsEqual = lowercaseChar == uppercaseChar
            
            let lowercaseRanges = rangesFn(lowercaseChar)
            let uppercaseRanges = charsEqual ? [] : rangesFn(uppercaseChar)
            
            return lowercaseRanges + uppercaseRanges
        }
    }
    
    private func showResultsForRanges(ranges: [NSRange]) {
        
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
        labelsController.initialize(zip(ranges, rects).map { .init(range: $0, rect: $1) })
    }
    
    private func abort() {
        state = .Inactive
        removeTextField()
        labelsController.cancel()
        currentEditorView.window?.makeFirstResponder(currentEditorView)
    }

    private func jump(var range: NSRange) {
        range.length = 0
        currentEditorView.setSelectedRange(range)
        currentEditorView.window?.makeFirstResponder(currentEditorView)
    }
    
    // MARK:- SingleCharTextFieldDelegate
    
    func didRecieveChar(textField: SingleCharTextField, char: Character) {
        switch state {
        case .InputChar:
            hideTextField()
            showResultsForRanges(rangesForChar(char))
        case .ShowCandidates:
            if let result = labelsController.next(char) {
                removeTextField()
                state = .Inactive
                jump(result.location.range)
            }
        default:
            break
        }
    }
    
    func didLoseFocus(textField: SingleCharTextField) {
        abort()
    }
    
}
