//
//  DSNTests.swift
//  SentryKit
//
//  Created by David Chavez on 9/3/16.
//  Copyright © 2016 David Chavez. All rights reserved.
//

import XCTest
@testable import SentryKit

class DSNTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testValidDSN() {
        do {
            let object = try DSN(dsn: "https://public:secret@dcvz.io/1")
            XCTAssertEqual(object.scheme, "https")
            XCTAssertEqual(object.publicKey, "public")
            XCTAssertEqual(object.secretKey, "secret")
            XCTAssertEqual(object.host.absoluteString, "dcvz.io")
            XCTAssertEqual(object.projectID, "1")
        } catch {
            XCTFail("Failed to parse a valid DSN")
        }
    }
    
    func testInvalidDSN() {
        do {
            let _ = try DSN(dsn: "https://public@sentry.example.com/1")
        } catch let e as DSNError {
            XCTAssertEqual(e, DSNError.invalid)
        } catch {
            XCTFail("Wrong error type")
        }
    }
}
