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
        case char, word, line
    }
    
    private enum State {
        case inactive, inputChar, showCandidates
    }
    
    // MARK:- Public properties
    
    var caseType = CaseType.insensitive
    var alphabet: [Character]! {
        didSet {
            if let a = alphabet, let b = oldValue, a != b {
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
    
    private var inputMode: InputMode = .char
    
    private var state: State = .inactive
    
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
        
        if state == .showCandidates {
            abort()
            return
        }

        currentEditorView = .activeEditorView
        
        if currentEditorView == nil {
            return
        }
        
        if mode == .line {
            state = .showCandidates
            showTextField()
            hideTextField()
            showLineCandidates()
        } else {
            state = .inputChar
            showTextField()
        }
    }
    
    // MARK:- Private methods
    
    private func initializeLabelController() {
        
        guard let view = currentEditorView, let alphabet = alphabet else { return }
        
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
    
    private func rangesForChar(_ char: Character) -> [NSRange] {
        
        let rangesFn: (Character) -> [NSRange]
        switch inputMode {
        case .word:
            rangesFn = currentEditorView.rangesOfBeginingWords
        case .char:
            rangesFn = currentEditorView.rangesOfVisible
        default:
            fatalError("Unhandled behavior")
        }
        
        if caseType == .sensitive {
            return rangesFn(char)
        } else {
            let lowercaseChar = Character(String(char).lowercased())
            let uppercaseChar = Character(String(char).uppercased())
            
            let charsEqual = lowercaseChar == uppercaseChar
            
            let lowercaseRanges = rangesFn(lowercaseChar)
            let uppercaseRanges = charsEqual ? [] : rangesFn(uppercaseChar)
            
            return lowercaseRanges + uppercaseRanges
        }
    }
    
    private func showResultsForRanges(_ ranges: [NSRange]) {
        
        let rects = ranges.map(currentEditorView.rectFromRange)
        
        if ranges.isEmpty {
            abort()
            return
        } else if ranges.count == 1 {
            jump(ranges.first!)
            state = .inactive
            removeTextField()
            return
        }
        
        state = .showCandidates
        labelsController.initialize(locations: zip(ranges, rects).map { .init(range: $0, rect: $1) })
    }
    
    private func abort() {
        state = .inactive
        removeTextField()
        labelsController.cancel()
        currentEditorView.window?.makeFirstResponder(currentEditorView)
    }

    private func jump(_ range: NSRange) {
        var range = range
        range.length = 0
        currentEditorView.setSelectedRange(range)
        currentEditorView.window?.makeFirstResponder(currentEditorView)
    }
    
    // MARK:- SingleCharTextFieldDelegate
    
    func didRecieveChar(_ textField: SingleCharTextField, char: Character) {
        switch state {
        case .inputChar:
            hideTextField()
            showResultsForRanges(rangesForChar(char))
        case .showCandidates:
            if let result = labelsController.next(char: char) {
                removeTextField()
                state = .inactive
                jump(result.location.range)
            }
        default:
            break
        }
    }
    
    func didLoseFocus(_ textField: SingleCharTextField) {
        abort()
    }
    
}
