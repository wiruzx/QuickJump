//
//  CandidateLabelsController.swift
//  XJump
//
//  Created by Victor Shamanov on 5/29/15.
//  Copyright (c) 2015 Victor Shamanov. All rights reserved.
//

import Foundation

final class CandidateLabelsController {
    
    // MARK:- Public properties
    
    let superview: NSView
    
    // MAKR:- Private properties
    
    private var candidateInfos: [CandidateInfo] = [] {
        didSet {
            displayCandidates()
        }
    }
    
    private var displayedLabels: [CATextLayer] = []
    
    // MAKR:- Instantiation
    
    init(superview: NSView) {
        self.superview = superview
    }
    
    // MARK:- Public methods
    
    func initialize(rangesAndRects: [(NSRange, NSRect)]) {
        candidateInfos = map(zip(candidates(rangesAndRects.count), rangesAndRects)) { c, rar in
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
        
        candidateInfos = newCandidates
        
        return nil
    }
    
    // MARK:- Private methods
    
    private func displayCandidates() {
        func addToSuperview(layer: CALayer) {
            superview.layer?.addSublayer(layer)
        }
        displayedLabels.each { $0.removeFromSuperlayer }
        displayedLabels = candidateInfos.map(labelFromInfo)
        displayedLabels.each(addToSuperview)
    }
    
    private func labelFromInfo(candidateInfo: CandidateInfo) -> CATextLayer {
        let label = CATextLayer()
        label.string = String(candidateInfo.candidate.char)
        label.frame = candidateInfo.rect
        return label
    }
    
}
