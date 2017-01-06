//
//  Coding.swift
//  QuickJump
//
//  Created by Victor Shamanov on 28.05.16.
//  Copyright © 2016 Victor Shamanov. All rights reserved.
//

protocol Encodable {
    func encode() -> [String: AnyObject]
}

protocol Decodable {
    init?(dictionary: [String: AnyObject])
}

extension Bool: Decodable, Encodable {
    
    init?(dictionary: [String: AnyObject]) {
        guard let value = dictionary["value"] as? Bool else { return nil }
        self.init(value)
    }
    
    func encode() -> [String: AnyObject] {
        return ["value": self as AnyObject]
    }
}
