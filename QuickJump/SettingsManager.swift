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

protocol KeyType {
    typealias EntityType: Decodable
    var key: String { get }
}

final class SettingsManager {
    
    // MARK:- Private properties
    
    private let userDefaults = NSUserDefaults.standardUserDefaults()
    
    // MARK:- Public methods
    
    func get<T: KeyType>(itemType: T) -> T.EntityType? {
        return (userDefaults.objectForKey(itemType.key) as? NSDictionaryLikeType).flatMap(T.EntityType.decode)
    }
    
    func set<T: Encodable, K: KeyType where T == K.EntityType>(object: T, forItemType itemType: K) {
        userDefaults.setObject(object.encode(), forKey: itemType.key)
    }
    
    func synchronize() {
        userDefaults.synchronize()
    }
}
