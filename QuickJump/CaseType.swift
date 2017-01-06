//
//  CaseType.swift
//  QuickJump
//
//  Created by Victor Shamanov on 6/4/15.
//  Copyright (c) 2015 Victor Shamanov. All rights reserved.
//

enum CaseType {
    case sensitive
    case insensitive
}

extension CaseType: Encodable, Decodable {
    
    func encode() -> [String: AnyObject] {
        
        let value: Int = {
            switch self {
            case .sensitive:
                return 0
            case .insensitive:
                return 1
            }
        }()
        
        return ["value":value as AnyObject]
    }
    
    init?(dictionary: [String: AnyObject]) {
        
        guard let value = dictionary["value"] as? Int else { return nil }
        
        switch value {
        case 0:
            self = .sensitive
        case 1:
            self = .insensitive
        default:
            assertionFailure("Invalid value \(value) for type \(CaseType.self)")
            return nil
        }
    }
}
    
