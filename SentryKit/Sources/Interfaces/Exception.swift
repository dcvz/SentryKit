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
    
    
    // MARK: - Initializers
    
    public init(value: String, type: String? = nil, module: String? = nil) {
        self.value = value
        self.type = type
        self.module = module
    }
}

internal extension Exception {
    /// The request-ready dictionary representation of the `Exception` struct.
    internal var dict: [String: Any] {
        // Any value (including embedded collections) should contain only `String` types.
        let attributes: [String: Any?] = [
            "value": value,
            "type": type,
            "module": module
        ]
        
        return attributes.filteringNil()
    }
}
