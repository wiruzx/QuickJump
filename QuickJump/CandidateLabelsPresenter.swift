//
//  CandidateLabelsPresenter.swift
//  QuickJump 
//
//  Created by Victor Shamanov on 5/29/15.
//  Copyright (c) 2015 Victor Shamanov. All rights reserved.
//

import AppKit

final class CandidateLabelsPresenter {
    
    // MAKR:- Private properties
    
    private let view: NSView
    private var interactor: CandidateLabelsInteractor {
        didSet {
            displayedLabels = interactor.candidateInfos.map(labelFromInfo)
        }
    }
    
    private let labelFactory = CandidateLabelFactory()
    
    private var displayedLabels: [CandidateLabelType] = [] {
        didSet {
            oldValue.forEach { $0.removeFromSuperview() }
            displayedLabels.forEach { $0.addToView(view) }
        }
    }
    
    // MAKR:- Instantiation
    
    init(view: NSView, alphabet: [Character]) {
        self.view = view
        self.interactor = .init(alphabet: alphabet)
    }
    
    // MARK:- Public methods
    
    func initialize(locations: [CandidateInfo.Location]) {
        interactor.initialize(locations: locations)
    }
    
    func next(char: Character) -> CandidateInfo? {
        return interactor.next(char: char)
    }
    
    func cancel() {
        interactor.cancel()
    }
    
    // MARK:- Private methods
    
    private func labelFromInfo(candidateInfo: CandidateInfo) -> CandidateLabelType {
        return labelFactory.label(frame: candidateInfo.location.rect, char: candidateInfo.candidate.char)
    }
    
}
