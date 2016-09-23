//
//  DictionaryTests.swift
//  SentryKit
//
//  Created by David Chavez on 9/14/16.
//  Copyright © 2016 David Chavez. All rights reserved.
//

import XCTest
@testable import SentryKit

class DictionaryTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAddition() {
        let first = ["key": "value", "test": "sample"]
        let second = ["key": "modified", "other": "thing"]
        
        let combined = first + second
        
        XCTAssertEqual(combined!["key"], "modified")
        XCTAssertEqual(combined!["test"], "sample")
        XCTAssertEqual(combined!["other"], "thing")
    }
}
