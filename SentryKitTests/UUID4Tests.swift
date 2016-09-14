//
//  UUID4Tests.swift
//  SentryKit
//
//  Created by David Chavez on 3/9/16.
//  Copyright © 2016 David Chavez. All rights reserved.
//

import XCTest
@testable import SentryKit

class uuid4Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func validateCreation() {
        let uuid = UUID4()
        XCTAssertEqual(uuid.hex.characters.count, 32)
        XCTAssert(uuid.hex.range(of: "-") == nil)
    }
}
