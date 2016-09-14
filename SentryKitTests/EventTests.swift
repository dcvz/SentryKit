//
//  EventTests.swift
//  SentryKit
//
//  Created by David Chavez on 9/3/16.
//  Copyright © 2016 David Chavez. All rights reserved.
//

import XCTest
@testable import SentryKit

class EventTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDefaultCreation() {
        let event = Event(message: "Hello")
        XCTAssertEqual(event.message, "Hello")
        XCTAssertEqual(event.level, .error)
        XCTAssertEqual(event.logger, "undefined.logger")
    }
    
    func testCompleteCreation() {
        let event = Event(message: "Hello", level: .fatal, logger: "hello.world")
        XCTAssertEqual(event.message, "Hello")
        XCTAssertEqual(event.level, .fatal)
        XCTAssertEqual(event.logger, "hello.world")
    }
    
    func testRequestDict() {
        let event = Event(message: "Hello", level: .fatal, logger: "hello.world")
        let dict = event.dict
        
        XCTAssertEqual(dict["event_id"] as? String, event.id)
        XCTAssertEqual(dict["message"] as? String, "Hello")
        XCTAssertEqual(dict["timestamp"] as? String, event.timestamp)
        XCTAssertEqual(dict["level"] as? String, "fatal")
        XCTAssertEqual(dict["logger"] as? String, "hello.world")
        XCTAssertEqual(dict["platform"] as? String, "cocoa")
        XCTAssertEqual(dict["sdk"] as! [String: String], Sentry.sdk)
        XCTAssertEqual(dict["device"] as! [String: String], event.device)
    }
}
