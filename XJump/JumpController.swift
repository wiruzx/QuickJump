//
//  JumpController.swift
//  XJump
//
//  Created by Victor Shamanov on 5/26/15.
//  Copyright (c) 2015 Victor Shamanov. All rights reserved.
//

import Foundation

final class JumpController {
    
    // MARK:- Private properties
    
    private var contextSubscription: NSObjectProtocol?
    
    // MARK:- Instantiation
    
    init() {
        
        let nc = NSNotificationCenter.defaultCenter()
        
        contextSubscription = nc.addObserverForName("IDEEditorAreaLastActiveEditorContextDidChangeNotification",
                                                    object: nil,
                                                    queue: nil,
                                                    usingBlock: { [weak self] in self?.activeEditorContextDidChange($0) })
        
    }
    
    deinit {
        contextSubscription.map(NSNotificationCenter.defaultCenter().removeObserver)
    }
    
    // MARK:- Private methods
    
    private func activeEditorContextDidChange(notification: NSNotification) {
        
    }
    
}
