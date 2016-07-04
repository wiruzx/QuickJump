//
//  CandidateInfo.swift
//  QuickJump 
//
//  Created by Victor Shamanov on 5/29/15.
//  Copyright (c) 2015 Victor Shamanov. All rights reserved.
//

import Foundation

struct CandidateInfo {
    
    struct Location {
        let range: NSRange
        let rect: NSRect
    }
    
    var candidate: Candidate
    let location: Location
    
    mutating func updateNextCandidate() -> Bool {
        guard let next = candidate.next() else { return false }
        candidate = next
        return true
    }
    
}
