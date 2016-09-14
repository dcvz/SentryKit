//
//  ExceptionTests.swift
//  SentryKit
//
//  Created by David Chavez on 14/9/16.
//  Copyright © 2016 David Chavez. All rights reserved.
//

import XCTest
@testable import SentryKit

class ExceptionTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRequestDict() {
        let exception = Exception(value: "text-exception", type: "awesome", module: "test")
        let dict = exception.dict
        
        XCTAssertEqual(dict["module"] as? String, "test")
        XCTAssertEqual(dict["type"] as? String, "awesome")
        XCTAssertEqual(dict["value"] as? String, "text-exception")
    }
}
