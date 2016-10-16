//
//  Functions.swift
//  QuickJump
//
//  Created by Victor Shamanov on 6/1/15.
//  Copyright (c) 2015 Victor Shamanov. All rights reserved.
//

import Foundation

func const<T, U>(_ x: U) -> (T) -> U {
    return { _ in x }
}
