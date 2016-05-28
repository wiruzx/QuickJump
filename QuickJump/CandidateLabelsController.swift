//
//  CandidateLabelsController.swift
//  QuickJump 
//
//  Created by Victor Shamanov on 5/29/15.
//  Copyright (c) 2015 Victor Shamanov. All rights reserved.
//

import Foundation

final class CandidateLabelsController {
    
    // MAKR:- Private properties
    
    private let superview: NSView
    private let candidateFactory: CandidateFactory
    
    private var candidateInfos: [CandidateInfo] = [] {
        didSet {
            displayedLabels = candidateInfos.map(labelFromInfo)
        }
    }
    
    private let labelFactory = CandidateLabelFactory()
    
    private var displayedLabels: [CandidateLabelType] = [] {
        didSet {
            oldValue.forEach { $0.removeFromSuperview() }
            displayedLabels.forEach { $0.addToView(superview) }
        }
    }
    
    // MAKR:- Instantiation
    
    init(superview: NSView, alphabet: [Character]) {
        self.superview = superview
        self.candidateFactory = CandidateFactory(alphabet: alphabet)
    }
    
    // MARK:- Deinitialization
    
    deinit {
        displayedLabels = []
    }
    
    // MARK:- Public methods
    
    func initialize(rangesAndRects: [(NSRange, NSRect)]) {
        
        let candidates = candidateFactory.candidates(rangesAndRects.count)
        
        candidateInfos = zip(candidates, rangesAndRects).map { candidate, rangeAndRect in
            
            let (range, rect) = rangeAndRect
            
            return CandidateInfo(candidate: candidate, range: range, rect: rect)
        }
    }
    
    func next(char: Character) -> CandidateInfo? {
        
        var matched = candidateInfos.filter { $0.candidate.char == char }
        
        for i in matched.indices {
            if let next = matched[i].candidate.next() {
                matched[i].candidate = next
            } else {
                return matched[i]
            }
        }
        
        // User input char which is not equal to any of candidates
        guard !matched.isEmpty else { return nil }
        
        candidateInfos = matched
        
        return nil
    }
    
    func cancel() {
        candidateInfos = []
    }
    
    // MARK:- Private methods
    
    private func labelFromInfo(candidateInfo: CandidateInfo) -> CandidateLabelType {
        return labelFactory.labelWithFrame(candidateInfo.rect, char: candidateInfo.candidate.char)
    }
    
}
