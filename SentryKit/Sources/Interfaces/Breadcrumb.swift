//
//  Breadcrumb.swift
//  SentryKit
//
//  Created by David Chavez on 13/9/16.
//  Copyright © 2016 David Chavez. All rights reserved.
//

import Foundation

/// A struct that describes an application event, or “breadcrumb”, that occurred before the main event.
public struct Breadcrumb {
    
    // MARK: - Enums
    
    public enum Severity: String {
        case critical, error, warning, info, debug
    }
    
    
    // MARK: - Attributes
    
    /**
     A dotted string that indicates what the crumb is or where it comes from (i.e. ui.tap).
     Typically it’s a module name or a descriptive string.
    */
    public let category: String?
    
    /// The type of breadcrumb.
    public let type: String?
    
    /// A timestamp representing when the breadcrumb occurred.
    internal let timestamp = Int(NSDate().timeIntervalSince1970)
    
    /// A message describing the breadcrumb
    public let message: String?
    
    /**
     This defines the level of the event.
     If not provided it defaults to info which is the middle level.
     Levels are used in the UI to emphasize and deemphasize the crumb.
    */
    public let level: Severity
    
    /**
     Data associated with this breadcrumb.
     Contains a sub-object whose contents depend on the breadcrumb type.
     Additional parameters that are unsupported by the type are rendered as a key/value table.
    */
    public let data: [String: Any]?
    
    
    // MARK: - Initializers
    
    public init(category: String, level: Severity = .info, message: String? = nil, data: [String: String]? = nil) {
        self.category = category
        self.type = nil
        self.level = level
        self.message = message
        self.data = data
    }
    
    internal init(type: String, level: Severity = .info, data: [String: Any]? = nil) {
        self.category = nil
        self.type = type
        self.level = level
        self.message = nil
        self.data = data
    }
}

public extension Breadcrumb {
    public static func navigationBreadcrumb(from: String, to: String) -> Breadcrumb {
        return Breadcrumb(type: "navigation", data: ["from": from, "to": to])
    }
    
    public static func httpBreadcrumb(url: String, method: String, statusCode: Int, reason: String) -> Breadcrumb {
        return Breadcrumb(type: "http", data: ["url": url, "method": method, "status_code": statusCode, "reason": reason])
    }
}

internal extension Breadcrumb {
    /// The request-ready dictionary representation of the `Breadcrumb` struct.
    internal var dict: [String: Any] {
        // Any value (including embedded collections) should contain only primitive types.
        let attributes: [String: Any?] = [
            "timestamp": timestamp,
            "message": message,
            "category": category,
            "type": type,
            "level": level.rawValue,
            "data": data
        ]
        
        return attributes.filteringNil()
    }
}
