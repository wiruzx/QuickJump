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
    private let settings = SettingsManager()

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
    
    private var caseSensitiveMenuItem: NSMenuItem?
    private var caseInsensitiveMenuItem: NSMenuItem?
    
    private func createMenuItems() {
        
        let quickJumpMenuName = "QuickJump"
        
        if let editorMenu = NSApplication.sharedApplication().mainMenu?.itemWithTitle("Editor")?.submenu
           where editorMenu.itemWithTitle(quickJumpMenuName) == nil {
            
            let quickJumpMenu = NSMenuItem(title: quickJumpMenuName, action: nil, keyEquivalent: "")
            
            let submenu = NSMenu()
            
            let actionMenuItem = NSMenuItem(title: "Toggle QuickJump", action: "toggleQuickJump", keyEquivalent: "")
            actionMenuItem.target = self
            submenu.addItem(actionMenuItem)
            
            let caseTypeSubmenu = NSMenu()
            
            let caseType = settings.get(CaseKey()) ?? .Sensitive
            
            jumpController.caseType = caseType
            
            let caseSensitiveItem = NSMenuItem(title: "Sensitive", action: "selectSensitive:", keyEquivalent: "")
            caseSensitiveItem.target = self
            caseSensitiveItem.state = caseType == .Sensitive ? 1 : 0
            caseTypeSubmenu.addItem(caseSensitiveItem)
            
            caseSensitiveMenuItem = caseSensitiveItem
            
            let caseInsensitiveItem = NSMenuItem(title: "Insensitive", action: "selectInsensitive:", keyEquivalent: "")
            caseInsensitiveItem.target = self
            caseInsensitiveItem.state = caseType == .Insensitive ? 1 : 0
            caseTypeSubmenu.addItem(caseInsensitiveItem)
            
            caseInsensitiveMenuItem = caseInsensitiveItem
            
            let caseTypeMenuItem = NSMenuItem(title: "Case sensivity", action: nil, keyEquivalent: "")
            
            caseTypeMenuItem.submenu = caseTypeSubmenu
            
            submenu.addItem(caseTypeMenuItem)
            
            quickJumpMenu.submenu = submenu
            
            editorMenu.insertItem(.separatorItem(), atIndex: 0)
            editorMenu.insertItem(quickJumpMenu, atIndex: 0)
            
        }
    }
    
    // MARK:- Actions

    @objc private func toggleQuickJump() {
        jumpController.toggle()
    }
    
    @objc private func selectSensitive(sender: AnyObject) {
        changeCaseType(.Sensitive)
    }
    
    @objc private func selectInsensitive(sender: AnyObject) {
        changeCaseType(.Insensitive)
    }
    
    // MARK:- Notifications
    
    @objc private func menuDidChange(notification: NSNotification) {
        createMenuItems()
    }
    
    // MARK:- Private methods
    
    private func changeCaseType(type: CaseType) {
        caseSensitiveMenuItem?.state = type == .Sensitive ? 1 : 0
        caseInsensitiveMenuItem?.state = type == .Insensitive ? 1 : 0
        
        jumpController.caseType = type
        
        settings.set(type, forItemType: CaseKey())
        settings.synchronize()
    }
    
}
