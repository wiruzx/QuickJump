//
//  SettingsManager.swift
//  QuickJump
//
//  Created by Victor Shamanov on 6/4/15.
//  Copyright (c) 2015 Victor Shamanov. All rights reserved.
//

import Foundation

typealias NSDictionaryLikeType = [NSObject: AnyObject]

protocol Encodable {
    func encode() -> NSDictionaryLikeType
}

protocol Decodable {
    static func decode(dictionary: NSDictionaryLikeType) -> Self?
}

final class SettingsManager {
    
    // MARK:- Type declarations
    
    enum Item {
        case CaseType
        
        private var key: String {
            switch self {
            case .CaseType:
                return "CaseType"
            }
        }
    }
    
    // MARK:- Private properties
    
    private let userDefaults = NSUserDefaults.standardUserDefaults()
    
    // MARK:- Public methods
    
    func get<T: Decodable>(itemType: Item) -> T? {
        return (userDefaults.objectForKey(itemType.key) as? NSDictionaryLikeType).flatMap(T.self.decode)
    }
    
    func set<T: Encodable>(object: T, forItemType itemType: Item) {
        userDefaults.setObject(object.encode(), forKey: itemType.key)
    }
    
    func synchronize() {
        userDefaults.synchronize()
    }
}
