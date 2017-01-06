//
//  Storage.swift
//  QuickJump
//
//  Created by Victor Shamanov on 28.05.16.
//  Copyright © 2016 Victor Shamanov. All rights reserved.
//

import Foundation

protocol Storage {
    func object(forKey key: String) -> Any?
    mutating func set(_ value: Any?, forKey key: String)
    mutating func removeObjectForKey(_ key: String)
}

extension UserDefaults: Storage {}
