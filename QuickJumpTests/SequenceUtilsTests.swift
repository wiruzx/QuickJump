//
//  SequenceUtilsTests.swift
//  QuickJump
//
//  Created by Victor Shamanov on 05.06.16.
//  Copyright © 2016 Victor Shamanov. All rights reserved.
//

import XCTest

private struct InfiniteSequence: SequenceType {
    func generate() -> AnyGenerator<Int> {
        var counter = 0
        return anyGenerator {
            defer { counter += 1 }
            return counter
        }
    }
}

class SequenceSkipTests: XCTestCase {
    
    func testSimple() {
        
        let seq = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        
        let result = seq.skip(5)
        
        XCTAssertEqual(Array(result), [5, 6, 7, 8, 9])
    }
    
    func testEmpty() {
        
        let seq: [Int] = []
        
        let result = seq.skip(10)
        
        XCTAssertEqual(Array(result), [])
    }
    
    func testOutOfRange() {
        
        let seq = [1, 2, 3]
        
        let result = seq.skip(10)
        
        XCTAssertTrue(Array(result).isEmpty)
    }
    
    func testZero() {
        
        let seq = [1, 2, 3, 4, 5]
        
        let result = seq.skip(0)
        
        XCTAssertEqual(Array(result), seq)
    }
}

class SequenceTakeTests: XCTestCase {
    
    func testInfinite() {
        
        let seq = InfiniteSequence()
        
        let result = seq.take(5)
        
        XCTAssertEqual(Array(result), [0, 1, 2, 3, 4])
    }
    
    func testOutOfRange() {
        
        let seq = [1, 2, 3, 4, 5]
        
        let result = seq.take(10)
        
        XCTAssertEqual(Array(result), seq)
    }
    
    func testZero() {
        
        let seq = [1, 2, 3, 4, 5]
        
        let result = seq.take(0)
        
        XCTAssertTrue(Array(result).isEmpty)
    }
    
    func testEmpty() {
        
        let seq: [Int] = []
        
        let result = seq.take(5)
        
        XCTAssertTrue(Array(result).isEmpty)
    }
    
}

class SequenceFindTests: XCTestCase {
    
    func test() {
        
        let seq = InfiniteSequence()
        
        let element = seq.find { $0 == 5 }
        
        XCTAssertEqual(element, 5)
    }
    
    func testFindingFirst() {
        
        typealias Element = (key: Int, value: String)
        
        let seq: [Element] = [(1, "first"), (2, "foo"), (1, "second")]
        
        let element = seq.find { $0.key == 1 }
        
        XCTAssertEqual(element?.value, "first")
    }
    
}
