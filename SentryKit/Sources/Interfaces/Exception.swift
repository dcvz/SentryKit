//
//  Exception.swift
//  SentryKit
//
//  Created by David Chavez on 13/9/16.
//  Copyright (c) 2016 David Chavez. All rights reserved.
//

import Foundation

/// A struct that describes failures (errors, exceptions) in an application.
public struct Exception {
    
    // MARK: - Attributes
    
    /// The description of the exception.
    public var value: String
    
    /// The description of the exception class.
    public var type: String?
    
    /// The module namespace.
    public var module: String?
    
    
    // MARK: - Instantiation
    
    /// Creates a new `Exception` object
    ///
    /// - Parameters:
    ///   - value: A basic description of the exception.
    ///   - type: The description of the exception class.
    ///   - module: The module namespace
    public init(value: String, type: String? = nil, module: String? = nil) {
        self.value = value
        self.type = type
        self.module = module
    }
}


// MARK: - Serializable Protocol Extension

extension Exception: Serializable {
    
    /// A request-ready dictionary representation of the `Exception` struct.
    internal var json: [String: Any] {
        let attributes: [String: Any?] = [
            "value": value,
            "type": type,
            "module": module
        ]
        
        return JSON.sanitize(json: attributes.removingNil()) as! [String: Any]
    }
}
