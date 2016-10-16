//
//  QuickJump.swift
//  QuickJump
//
//  Created by Victor Shamanov on 5/26/15.
//  Copyright (c) 2015 Victor Shamanov. All rights reserved.
//

import Foundation

final class QuickJump: NSObject {
    
    private let jumpController = JumpController()
    private let settings: SettingsManager<SettingsKey> = .init(storage: UserDefaults.standard)

    init(bundle _: Bundle) {

        super.init()
        
        NotificationCenter.default.addObserver(self, 
                                               selector: #selector(menuDidChange),
                                               name: NSNotification.Name.NSMenuDidChangeItem,
                                               object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.NSMenuDidChangeItem, object: nil)
    }
    
    private var caseSensitiveMenuItem: NSMenuItem?
    private var caseInsensitiveMenuItem: NSMenuItem?
    private var uppercaseCandidatesMenuItem: NSMenuItem?
    private var forcedEnglishLayoutMenuItem: NSMenuItem?
    
    private func createMenuItems() {
        
        let quickJumpMenuName = "QuickJump"
        
        if let editorMenu = NSApplication.shared().mainMenu?.item(withTitle: "Editor")?.submenu,
            editorMenu.item(withTitle: quickJumpMenuName) == nil {
            
            let quickJumpMenu = NSMenuItem(title: quickJumpMenuName, action: nil, keyEquivalent: "")
            
            let submenu = NSMenu()
            
            let charModeItem = NSMenuItem(title: "QuickJump: char mode", action: #selector(charMode), keyEquivalent: "")
            charModeItem.target = self
            submenu.addItem(charModeItem)
            
            let wordModeItem = NSMenuItem(title: "QuickJump: word mode", action: #selector(wordMode), keyEquivalent: "")
            wordModeItem.target = self
            submenu.addItem(wordModeItem)
            
            let lineModeItem = NSMenuItem(title: "QuickJump: line mode", action: #selector(lineMode), keyEquivalent: "")
            lineModeItem.target = self
            submenu.addItem(lineModeItem)
            
            submenu.addItem(.separator())

            let caseTypeSubmenu = NSMenu()
            
            let caseTypeMenuItem = NSMenuItem(title: "Case sensivity", action: nil, keyEquivalent: "")
            caseTypeMenuItem.submenu = caseTypeSubmenu
            submenu.addItem(caseTypeMenuItem)
            
            let caseType: CaseType = settings.get(.caseType) ?? .sensitive
            jumpController.caseType = caseType
            
            let alphabet: Alphabet = settings.get(.alphabet) ?? .defaultAlphabet
            jumpController.alphabet = alphabet.chars
            
            let forcedLayoutEnabled: Bool = settings.get(.forceEnglishKeyboard) ?? false
            jumpController.forcedEnglishLayout = forcedLayoutEnabled
            
            let uppercaseCandidatesItem = NSMenuItem(title: "Allow Uppercase candidates",
                                                     action: #selector(changeEnableUppercaseCandidatesToggle),
                                                     keyEquivalent: "")
            uppercaseCandidatesItem.target = self
            uppercaseCandidatesItem.state = alphabet == .latinWithUppercase ? 1 : 0
            
            submenu.addItem(.separator())
            submenu.addItem(uppercaseCandidatesItem)
            
            uppercaseCandidatesMenuItem = uppercaseCandidatesItem
            
            let forcedEnglishLayoutItem = NSMenuItem(title: "Force English keyboard layout",
                                                     action: #selector(changeEnableForcedEnglishLayoutToogle),
                                                     keyEquivalent: "")
            
            forcedEnglishLayoutItem.target = self
            forcedEnglishLayoutItem.state = forcedLayoutEnabled ? 1 : 0
            
            submenu.addItem(.separator())
            submenu.addItem(forcedEnglishLayoutItem)
            
            forcedEnglishLayoutMenuItem = forcedEnglishLayoutItem
            
            let caseSensitiveItem = NSMenuItem(title: "Sensitive", action: #selector(selectSensitive), keyEquivalent: "")
            caseSensitiveItem.target = self
            caseSensitiveItem.state = caseType == .sensitive ? 1 : 0
            caseTypeSubmenu.addItem(caseSensitiveItem)
            
            caseSensitiveMenuItem = caseSensitiveItem
            
            let caseInsensitiveItem = NSMenuItem(title: "Insensitive", action: #selector(selectInsensitive), keyEquivalent: "")
            caseInsensitiveItem.target = self
            caseInsensitiveItem.state = caseType == .insensitive ? 1 : 0
            caseTypeSubmenu.addItem(caseInsensitiveItem)
            
            caseInsensitiveMenuItem = caseInsensitiveItem
            
            quickJumpMenu.submenu = submenu
            
            editorMenu.insertItem(.separator(), at: 0)
            editorMenu.insertItem(quickJumpMenu, at: 0)
            
        }
    }
    
    // MARK:- Actions

    @objc private func charMode() {
        jumpController.toggle(mode: .char)
    }
    
    @objc private func wordMode() {
        jumpController.toggle(mode: .word)
    }
    
    @objc private func lineMode() {
        jumpController.toggle(mode: .line)
    }
    
    @objc private func selectSensitive(sender: AnyObject) {
        changeCaseType(.sensitive)
    }
    
    @objc private func selectInsensitive(sender: AnyObject) {
        changeCaseType(.insensitive)
    }
    
    @objc private func changeEnableUppercaseCandidatesToggle(sender: AnyObject) {
        changeUppercaseCandidates()
    }
    
    @objc private func changeEnableForcedEnglishLayoutToogle(sender: AnyObject) {
        changeForcedEnglishLayoutOption()
    }
    
    // MARK:- Notifications
    
    @objc private func menuDidChange(notification: NSNotification) {
        DispatchQueue.main.async(execute: createMenuItems)
    }
    
    // MARK:- Private methods
    
    private func changeForcedEnglishLayoutOption() {
        let current: Bool = settings.get(.forceEnglishKeyboard) ?? false
        
        let new = !current
        
        jumpController.forcedEnglishLayout = new
        forcedEnglishLayoutMenuItem?.state = new ? 1 : 0
        
        settings.set(value: new, forKey: .forceEnglishKeyboard)
    }
    
    private func changeUppercaseCandidates() {
        
        let current: Alphabet = settings.get(.alphabet) ?? .defaultAlphabet
        
        let newAlphabet: Alphabet
        if current == .latinWithUppercase {
            uppercaseCandidatesMenuItem?.state = 0
            newAlphabet = .latin
        } else {
            uppercaseCandidatesMenuItem?.state = 1
            newAlphabet = .latinWithUppercase
        }
        
        jumpController.alphabet = newAlphabet.chars
        
        settings.set(value: newAlphabet, forKey: .alphabet)
    }
    
    private func changeCaseType(_ type: CaseType) {
        caseSensitiveMenuItem?.state = type == .sensitive ? 1 : 0
        caseInsensitiveMenuItem?.state = type == .insensitive ? 1 : 0
        
        jumpController.caseType = type
        
        settings.set(value: type, forKey: .caseType)
    }
    
}
