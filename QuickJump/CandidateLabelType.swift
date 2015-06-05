//
//  CandidateLabelType.swift
//  QuickJump
//
//  Created by Victor Shamanov on 6/1/15.
//  Copyright (c) 2015 Victor Shamanov. All rights reserved.
//

import Foundation

protocol CandidateLabelType: class {
    
    func addToView(view: NSView)
    func removeFromSuperview()
    
}
