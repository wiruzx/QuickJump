//
//  CaseType.swift
//  QuickJump
//
//  Created by Victor Shamanov on 6/4/15.
//  Copyright (c) 2015 Victor Shamanov. All rights reserved.
//

import Foundation

enum CaseType {
    case Sensitive
    case Insensitive
}

extension CaseType: Encodable, Decodable {
    
    func encode() -> NSDictionaryLikeType {
        
        let value: Int = {
            switch self {
            case .Sensitive:
                return 0
            case .Insensitive:
                return 1
            }
        }()
        
        return ["value":value]
    }
    
    static func decode(dictionary: NSDictionaryLikeType) -> CaseType? {
        switch dictionary["value"] as? Int {
        case .Some(0):
            return .Sensitive
        case .Some(1):
            return .Insensitive
        default:
            return nil
        }
    }
    
}
