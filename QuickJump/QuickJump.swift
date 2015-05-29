//
//  QuickJump.swift
//  QuickJump
//
//  Created by Victor Shamanov on 5/26/15.
//  Copyright (c) 2015 Victor Shamanov. All rights reserved.
//

import AppKit

var sharedPlugin: QuickJump?

class QuickJump: NSObject {
    var bundle: NSBundle
    
    var jumpController = JumpController()

    init(bundle: NSBundle) {
        self.bundle = bundle

        super.init()
        createMenuItems()
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    func createMenuItems() {
        var item = NSApp.mainMenu!!.itemWithTitle("Edit")
        if item != nil {
            var actionMenuItem = NSMenuItem(title:"Toggle QuickJump", action:"toggleQuickJump", keyEquivalent:"")
            actionMenuItem.target = self
            item!.submenu!.addItem(NSMenuItem.separatorItem())
            item!.submenu!.addItem(actionMenuItem)
        }
    }

    func toggleQuickJump() {
        jumpController.toggle()
    }
}

