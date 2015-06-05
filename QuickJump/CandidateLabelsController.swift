//
//  CandidateLabelsController.swift
//  QuickJump 
//
//  Created by Victor Shamanov on 5/29/15.
//  Copyright (c) 2015 Victor Shamanov. All rights reserved.
//

import Foundation

final class CandidateLabelsController {
    
    // MARK:- Public properties
    
    let superview: NSView
    let alphabet: [Character]
    
    // MAKR:- Private properties
    
    private var candidateInfos: [CandidateInfo] = [] {
        didSet {
            displayCandidates()
        }
    }
    
    private var labelFactory = CandidateLabelFactory()
    private var displayedLabels: [CandidateLabelType] = []
    
    // MAKR:- Instantiation
    
    init(superview: NSView, alphabet: [Character]) {
        self.superview = superview
        self.alphabet = alphabet
    }
    
    // MARK:- Deinitialization
    
    deinit {
        displayedLabels.each { $0.removeFromSuperview() }
    }
    
    // MARK:- Public methods
    
    func initialize(rangesAndRects: [(NSRange, NSRect)]) {
        candidateInfos = map(zip(candidatesForCount(alphabet)(rangesAndRects.count), rangesAndRects)) { c, rar in
            CandidateInfo(candidate: c, range: rar.0, rect: rar.1)
        }
    }
    
    func next(char: Character) -> CandidateInfo? {
        
        let matched = candidateInfos.filter { $0.candidate.char == char }
        
        var newCandidates = [CandidateInfo]()
        
        for info in matched {
            if let next = info.candidate.next() {
                var newCandidate = info
                newCandidate.candidate = next
                newCandidates.append(newCandidate)
            } else {
                candidateInfos = []
                return info
            }
        }
        
        // User input char which is not equal to any of candidates
        if newCandidates.isEmpty {
            return nil
        }

        candidateInfos = newCandidates
        
        return nil
    }
    
    func cancel() {
        candidateInfos = []
    }
    
    // MARK:- Private methods
    
    private func displayCandidates() {
        displayedLabels.each { $0.removeFromSuperview() }
        displayedLabels = candidateInfos.map(labelFromInfo)
        displayedLabels.each { $0.addToView(superview) }
    }
    
    private func labelFromInfo(candidateInfo: CandidateInfo) -> CandidateLabelType {
        return labelFactory.labelWithFrame(candidateInfo.rect, char: candidateInfo.candidate.char)
    }
    
}
