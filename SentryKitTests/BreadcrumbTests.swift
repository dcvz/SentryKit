//
//  BreadcrumbTests.swift
//  SentryKit
//
//  Created by David Chavez on 9/14/16.
//  Copyright © 2016 David Chavez. All rights reserved.
//

import XCTest
@testable import SentryKit

class BreadcrumbTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNavigationBreadcrumb() {
        let breadcrumb = Breadcrumb.navigationBreadcrumb(from: "launch", to: "view")
        
        XCTAssertEqual(breadcrumb.type, "navigation")
        XCTAssertEqual(breadcrumb.data as! [String: String], ["from": "launch", "to": "view"])
        XCTAssertEqual(breadcrumb.level, .info)
        XCTAssertEqual(breadcrumb.category, nil)
        XCTAssertEqual(breadcrumb.message, nil)
        
        let dict = breadcrumb.json
        
        XCTAssertEqual(dict["type"] as! String, "navigation")
        XCTAssertEqual(dict["level"] as! String, "info")
        XCTAssertEqual(dict["data"] as! [String: String], ["from": "launch", "to": "view"])
    }
    
    func testHTTPBreadcrumb() {
        let breadcrumb = Breadcrumb.httpBreadcrumb(url: "dcvz.io", method: "GET", statusCode: 200, reason: "OK")
        
        XCTAssertEqual(breadcrumb.type, "http")
        XCTAssertEqual(breadcrumb.level, .info)
        XCTAssertEqual(breadcrumb.category, nil)
        XCTAssertEqual(breadcrumb.message, nil)

        XCTAssertEqual(breadcrumb.data!["url"] as! String, "dcvz.io")
        XCTAssertEqual(breadcrumb.data!["method"] as! String, "GET")
        XCTAssertEqual(breadcrumb.data!["status_code"] as! Int, 200)
        XCTAssertEqual(breadcrumb.data!["reason"] as! String, "OK")
        
        let dict = breadcrumb.json
        
        XCTAssertEqual(dict["type"] as! String, "http")
        XCTAssertEqual(dict["level"] as! String, "info")
    }
    
    func testRequestDict() {
        let breadcrumb = Breadcrumb.navigationBreadcrumb(from: "launch", to: "view")
        let dict = breadcrumb.json
        
        XCTAssertEqual(dict["type"] as! String, "navigation")
        XCTAssertEqual(dict["level"] as! String, "info")
        XCTAssertEqual(dict["data"] as! [String: String], ["from": "launch", "to": "view"])
    }
}
