//
//  CaseType.swift
//  QuickJump
//
//  Created by Victor Shamanov on 6/4/15.
//  Copyright (c) 2015 Victor Shamanov. All rights reserved.
//

enum CaseType {
    case Sensitive
    case Insensitive
}

extension CaseType: Encodable, Decodable {
    
    func encode() -> [String: AnyObject] {
        
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
    
    init?(dictionary: [String: AnyObject]) {
        
        guard let value = dictionary["value"] as? Int else { return nil }
        
        switch value {
        case 0:
            self = .Sensitive
        case 1:
            self = .Insensitive
        default:
            assertionFailure("Invalid value \(value) for type \(CaseType.self)")
            return nil
        }
    }
}
    