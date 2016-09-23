//
//  UserTests.swift
//  SentryKit
//
//  Created by David Chavez on 14/9/16.
//  Copyright © 2016 David Chavez. All rights reserved.
//

import XCTest
@testable import SentryKit

class UserTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRequestDict() {
        let user = User(id: "user-id", username: "dcvz", email: "david@awesome.com", extra: ["key": "value"])
        let dict = user.json
        
        XCTAssertEqual(dict["id"] as! String, "user-id")
        XCTAssertEqual(dict["username"] as! String, "dcvz")
        XCTAssertEqual(dict["email"] as! String, "david@awesome.com")
        XCTAssertEqual(dict["extra"] as! [String: String], ["key": "value"])
    }
}
