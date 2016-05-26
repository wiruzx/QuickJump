//
//  QuickJump.swift
//  QuickJump
//
//  Created by Victor Shamanov on 5/26/15.
//  Copyright (c) 2015 Victor Shamanov. All rights reserved.
//

import Foundation

final class QuickJump: NSObject {
    
    static var sharedPlugin: QuickJump?
    
    let bundle: NSBundle
    
    private let jumpController = JumpController()
    private let settings = SettingsManager()

    init(bundle: NSBundle) {
        self.bundle = bundle

        super.init()
        
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
    private var uppercaseCandidatesMenuItem: NSMenuItem?
    private var forcedEnglishLayoutMenuItem: NSMenuItem?
    
    private func createMenuItems() {
        
        let quickJumpMenuName = "QuickJump"
        
        if let editorMenu = NSApplication.sharedApplication().mainMenu?.itemWithTitle("Editor")?.submenu
           where editorMenu.itemWithTitle(quickJumpMenuName) == nil {
            
            let quickJumpMenu = NSMenuItem(title: quickJumpMenuName, action: nil, keyEquivalent: "")
            
            let submenu = NSMenu()
            
            let charModeItem = NSMenuItem(title: "QuickJump: char mode", action: "charMode", keyEquivalent: "")
            charModeItem.target = self
            submenu.addItem(charModeItem)
            
            let wordModeItem = NSMenuItem(title: "QuickJump: word mode", action: "wordMode", keyEquivalent: "")
            wordModeItem.target = self
            submenu.addItem(wordModeItem)
            
            let lineModeItem = NSMenuItem(title: "QuickJump: line mode", action: "lineMode", keyEquivalent: "")
            lineModeItem.target = self
            submenu.addItem(lineModeItem)
            
            submenu.addItem(.separatorItem())

            let caseTypeSubmenu = NSMenu()
            
            let caseTypeMenuItem = NSMenuItem(title: "Case sensivity", action: nil, keyEquivalent: "")
            caseTypeMenuItem.submenu = caseTypeSubmenu
            submenu.addItem(caseTypeMenuItem)
            
            let caseType = settings.get(CaseKey()) ?? .Sensitive
            jumpController.caseType = caseType
            
            let alphabet = settings.get(AlphabetKey()) ?? .DefaultAlphabet
            jumpController.alphabet = alphabet.chars
            
            let forcedLayoutEnabled = settings.get(ForcedEnglishKeyboardKey()) ?? false
            jumpController.forcedEnglishLayout = forcedLayoutEnabled
            
            let uppercaseCandidatesItem = NSMenuItem(title: "Allow Uppercase candidates",
                                                     action: "changeEnableUppercaseCandidatesToggle:",
                                                     keyEquivalent: "")
            uppercaseCandidatesItem.target = self
            uppercaseCandidatesItem.state = alphabet == .LatinWithUppercase ? 1 : 0
            
            submenu.addItem(.separatorItem())
            submenu.addItem(uppercaseCandidatesItem)
            
            uppercaseCandidatesMenuItem = uppercaseCandidatesItem
            
            let forcedEnglishLayoutItem = NSMenuItem(title: "Force English keyboard layout",
                                                     action: "changeEnableForcedEnglishLayoutToogle:",
                                                     keyEquivalent: "")
            
            forcedEnglishLayoutItem.target = self
            forcedEnglishLayoutItem.state = forcedLayoutEnabled ? 1 : 0
            
            submenu.addItem(.separatorItem())
            submenu.addItem(forcedEnglishLayoutItem)
            
            forcedEnglishLayoutMenuItem = forcedEnglishLayoutItem
            
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
            
            quickJumpMenu.submenu = submenu
            
            editorMenu.insertItem(.separatorItem(), atIndex: 0)
            editorMenu.insertItem(quickJumpMenu, atIndex: 0)
            
        }
    }
    
    // MARK:- Actions

    @objc private func charMode() {
        jumpController.toggle(.Char)
    }
    
    @objc private func wordMode() {
        jumpController.toggle(.Word)
    }
    
    @objc private func lineMode() {
        jumpController.toggle(.Line)
    }
    
    @objc private func selectSensitive(sender: AnyObject) {
        changeCaseType(.Sensitive)
    }
    
    @objc private func selectInsensitive(sender: AnyObject) {
        changeCaseType(.Insensitive)
    }
    
    @objc private func changeEnableUppercaseCandidatesToggle(sender: AnyObject) {
        changeUppercaseCandidates()
    }
    
    @objc private func changeEnableForcedEnglishLayoutToogle(sender: AnyObject) {
        changeForcedEnglishLayoutOption()
    }
    
    // MARK:- Notifications
    
    @objc private func menuDidChange(notification: NSNotification) {
        dispatch_async(dispatch_get_main_queue(), createMenuItems)
    }
    
    // MARK:- Private methods
    
    private func changeForcedEnglishLayoutOption() {
        let current = settings.get(ForcedEnglishKeyboardKey()) ?? false
        
        let new = !current
        
        jumpController.forcedEnglishLayout = new
        forcedEnglishLayoutMenuItem?.state = new ? 1 : 0
        
        settings.set(new, forItemType: ForcedEnglishKeyboardKey())
        settings.synchronize()
    }
    
    private func changeUppercaseCandidates() {
        
        let current = settings.get(AlphabetKey()) ?? .DefaultAlphabet
        
        let newAlphabet: Alphabet
        if current == .LatinWithUppercase {
            uppercaseCandidatesMenuItem?.state = 0
            newAlphabet = .Latin
        } else {
            uppercaseCandidatesMenuItem?.state = 1
            newAlphabet = .LatinWithUppercase
        }
        
        jumpController.alphabet = newAlphabet.chars
        settings.set(newAlphabet, forItemType: AlphabetKey())
        settings.synchronize()
        
    }
    
    private func changeCaseType(type: CaseType) {
        caseSensitiveMenuItem?.state = type == .Sensitive ? 1 : 0
        caseInsensitiveMenuItem?.state = type == .Insensitive ? 1 : 0
        
        jumpController.caseType = type
        
        settings.set(type, forItemType: CaseKey())
        settings.synchronize()
    }
    
}
