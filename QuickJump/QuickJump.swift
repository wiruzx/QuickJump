//
//  QuickJump.swift
//  QuickJump
//
//  Created by Victor Shamanov on 5/26/15.
//  Copyright (c) 2015 Victor Shamanov. All rights reserved.
//

import AppKit

final class QuickJump: NSObject {
    
    static var sharedPlugin: QuickJump?
    
    let bundle: NSBundle
    
    private let jumpController = JumpController()

    init(bundle: NSBundle) {
        self.bundle = bundle

        super.init()
        
        createMenuItems()
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    private func createMenuItems() {
        if let submenu = NSApp.mainMenu??.itemWithTitle("Edit")?.submenu {
            let actionMenuItem = NSMenuItem(title: "Toggle QuickJump", action: "toggleQuickJump", keyEquivalent: "")
            actionMenuItem.target = self
            submenu.addItem(.separatorItem())
            submenu.addItem(actionMenuItem)
        }
    }

    @objc private func toggleQuickJump() {
        jumpController.toggle()
    }
}
