//
//  SequenceTypeUtils.swift
//  QuickJump
//
//  Created by Victor Shamanov on 6/1/15.
//  Copyright (c) 2015 Victor Shamanov. All rights reserved.
//

import Foundation

func skip<S: SequenceType>(count: Int)(_ sequence: S) -> AnySequence<S.Generator.Element> {
    var generator = sequence.generate()
    for _ in 0 ..< count {
        let _ = generator.next()
    }
    return AnySequence(anyGenerator { generator.next() })
}
