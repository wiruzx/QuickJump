//
//  NSTextView+CandidateLabelType.swift
//  QuickJump
//
//  Created by Victor Shamanov on 6/1/15.
//  Copyright (c) 2015 Victor Shamanov. All rights reserved.
//

import Foundation

extension NSTextView: CandidateLabelType {
    
    func addToView(view: NSView) {
        view.addSubview(self)
    }

}