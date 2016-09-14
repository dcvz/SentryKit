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
    
    func testCaptureErrorMissingDSN() {
        Sentry.shared.dsn = nil
        
        do {
            try Sentry.shared.captureError(message: "", culprit: "", exception: Exception(value: ""))
            XCTFail("Should throw with missing DSN")
        } catch let e as SentryError {
            XCTAssertEqual(e, SentryError.missingDSN)
        } catch {
            XCTFail("Wrong error type")
        }

    }
    
    func testAddingBreadcrumbs() {
        let client = Sentry.shared
        
        let firstBC = Breadcrumb(category: "first-bc")
        let secondBC = Breadcrumb(category: "second-bc")
        
        client.addBreadcrumb(firstBC)
        client.addBreadcrumb(secondBC)
        
        XCTAssertEqual(client.breadcrumbs!.first!, firstBC)
        XCTAssertEqual(client.breadcrumbs!.last!, secondBC)
    }
    
    func testClearingBreadcrumbs() {
        let client = Sentry.shared
        
        let firstBC = Breadcrumb(category: "first-bc")
        let secondBC = Breadcrumb(category: "second-bc")
        
        client.addBreadcrumb(firstBC)
        client.addBreadcrumb(secondBC)
        
        client.clearBreadcrumbs()
        
        XCTAssert(client.breadcrumbs == nil)
    }
}
