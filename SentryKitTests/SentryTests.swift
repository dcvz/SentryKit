//
//  SentryTests.swift
//  SentryKit
//
//  Created by David Chavez on 9/9/16.
//  Copyright © 2016 David Chavez. All rights reserved.
//

import XCTest
@testable import SentryKit

class SentryTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let dsn = try! DSN(dsn: "https://public:secret@dcvz.io/1")
        Sentry.shared.dsn = dsn
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCaptureMessageMissingDSN() {
        Sentry.shared.dsn = nil
        
        do {
            try Sentry.shared.captureMessage("request.missing.dsn.test")
            XCTFail("Should throw with missing DSN")
        } catch let e as SentryError {
            XCTAssertEqual(e, SentryError.missingDSN)
        } catch {
            XCTFail("Wrong error type")
        }
    }
    
    func testSendEvent() {
        try! Sentry.shared.captureMessage("request.success.test")
        
        // TO:DO - inspect request content
    }
}
