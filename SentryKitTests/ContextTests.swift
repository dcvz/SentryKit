//
//  ContextTests.swift
//  SentryKit
//
//  Created by David Chavez on 9/9/16.
//  Copyright © 2016 David Chavez. All rights reserved.
//

import XCTest
@testable import SentryKit

class ContextTests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testClear() {
        let user = User(id: "test-id", username: "dcvz", email: "david@test.com", extra: ["extra": "value"])
        let context = Context()
        context.user = user
        context.tags = ["extra": "tag"]
        context.extra = ["extra": "meta"]
        
        context.clear()
        
        XCTAssert(context.user == nil)
        XCTAssert(context.tags == nil)
        XCTAssert(context.extra == nil)
    }
}
