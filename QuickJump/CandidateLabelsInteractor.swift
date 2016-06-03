//
//  CandidateLabelsInteractor.swift
//  QuickJump
//
//  Created by Victor Shamanov on 30.05.16.
//  Copyright © 2016 Victor Shamanov. All rights reserved.
//

struct CandidateLabelsInteractor {
    
    private let candidateFactory: CandidateFactory
    
    private(set) var candidateInfos: [CandidateInfo] = []
    
    init(alphabet: [Character]) {
        candidateFactory = .init(alphabet: alphabet)
    }
    
    mutating func initialize(locations: [CandidateInfo.Location]) {
        let candidates = candidateFactory.candidates(locations.count)
        candidateInfos = zip(candidates, locations).map { .init(candidate: $0, location: $1) }
    }
    
    mutating func next(char: Character) -> CandidateInfo? {
        var matched = candidateInfos.filter { $0.candidate.char == char }
        
        for index in matched.indices {
            if !matched[index].updateNextCandidate() {
                return matched[index]
            }
        }
        
        // User input char which is not equal to any of candidates
        guard !matched.isEmpty else { return nil }
        
        candidateInfos = matched
        
        return nil
    }
    
    mutating func cancel() {
        candidateInfos = []
    }
}
