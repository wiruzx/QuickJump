//
//  SettingsManager.swift
//  QuickJump
//
//  Created by Victor Shamanov on 6/4/15.
//  Copyright (c) 2015 Victor Shamanov. All rights reserved.
//

import Foundation

// MARK: - SettingsKey

enum SettingsKey: String {
    case Alphabet = "alphabet"
    case CaseType = "CaseType"
    case ForceEnglishKeyboard = "ForcedEnglishKeyboardKey"
}

// MARK: - SettingsManager

final class SettingsManager<Key: RawRepresentable where Key.RawValue == String> {
    
    // MARK: - Private properties
    
    private var storage: Storage
    
    // MARK: - Instantiation
    
    init(storage: Storage) {
        self.storage = storage
    }
    
    // MARK: - Public methods
    
    func get<T: Decodable>(key: Key) -> T? {
        
        guard let dictionary = storage.objectForKey(key.rawValue) as? [String: AnyObject] else { return nil }
        
        guard let value = T(dictionary: dictionary) else {
            assertionFailure("Value \(dictionary) for key \(key) cannot be converted to type \(T.self)")
            return nil
        }
        
        return value
    }
    
    func set(value: Encodable, forKey key: Key) {
        storage.setObject(value.encode(), forKey: key.rawValue)
    }
    
}
