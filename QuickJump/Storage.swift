//
//  Storage.swift
//  QuickJump
//
//  Created by Victor Shamanov on 28.05.16.
//  Copyright © 2016 Victor Shamanov. All rights reserved.
//

import Foundation

protocol Storage {
    func objectForKey(key: String) -> AnyObject?
    mutating func setObject(value: AnyObject?, forKey key: String)
    mutating func removeObjectForKey(key: String)
}

extension NSUserDefaults: Storage {}
