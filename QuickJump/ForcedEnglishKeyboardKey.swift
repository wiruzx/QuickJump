//
//  ForcedEnglishKeyboardKey.swift
//  QuickJump
//
//  Created by Victor Shamanov on 8/5/15.
//  Copyright (c) 2015 Victor Shamanov. All rights reserved.
//

import Foundation

extension Bool: Decodable, Encodable {
    static func decode(dictionary: NSDictionaryLikeType) -> Bool? {
        return dictionary["value"] as? Bool
    }
    
    func encode() -> NSDictionaryLikeType {
        return ["value": self]
    }
}

struct ForcedEnglishKeyboardKey: KeyType {
    typealias EntityType = Bool
    var key: String = "ForcedEnglishKeyboardKey"
}
