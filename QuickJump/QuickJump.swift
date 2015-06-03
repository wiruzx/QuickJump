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
        
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: "menuDidChange:",
                                                         name: NSMenuDidChangeItemNotification,
                                                         object: nil)
        
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self,
                                                            name: NSMenuDidChangeItemNotification,
                                                            object: nil)
    }
    
    private func createMenuItems() {
        
        let quickJumpMenuName = "QuickJump"
        
        if let editorMenu = NSApplication.sharedApplication().mainMenu?.itemWithTitle("Editor")?.submenu
           where editorMenu.itemWithTitle(quickJumpMenuName) == nil {
            
            let quickJumpMenu = NSMenuItem(title: quickJumpMenuName, action: nil, keyEquivalent: "")
            
            let submenu = NSMenu()
            
            let actionMenuItem = NSMenuItem(title: "Toggle QuickJump", action: "toggleQuickJump", keyEquivalent: "")
            actionMenuItem.target = self
            submenu.addItem(actionMenuItem)
            
            quickJumpMenu.submenu = submenu
            
            editorMenu.insertItem(.separatorItem(), atIndex: 0)
            editorMenu.insertItem(quickJumpMenu, atIndex: 0)
            
        }
    }
    
    // MARK:- Actions

    @objc private func toggleQuickJump() {
        jumpController.toggle()
    }
    
    // MARK:- Notifications
    
    @objc private func menuDidChange(notification: NSNotification) {
        createMenuItems()
    }
}
