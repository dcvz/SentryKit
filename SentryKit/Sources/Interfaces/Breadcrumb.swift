//
//  Breadcrumb.swift
//  SentryKit
//
//  Created by David Chavez on 13/9/16.
//  Copyright © 2016 David Chavez. All rights reserved.
//

import Foundation

public func ==(lhs: Breadcrumb, rhs: Breadcrumb) -> Bool {
    return lhs.timestamp == rhs.timestamp && lhs.category == rhs.category
}

/// A struct that describes an application event, or “breadcrumb”, that occurred before the main event.
public struct Breadcrumb: Equatable {
    
    // MARK: - Enums
    
    /// Denotes the severity level of a breadcrumb.
    public enum Severity: String {
        case critical, error, warning, info, debug
    }
    
    
    // MARK: - Attributes
    
    /// A dotted string that indicates what the crumb is or where it comes from (i.e. ui.tap).
    /// Typically it’s a module name or a descriptive string.
    public let category: String?
    
    /// The type of breadcrumb.
    public let type: String?
    
    /// A timestamp representing when the breadcrumb occurred.
    internal let timestamp = Int(NSDate().timeIntervalSince1970)
    
    /// A message describing the breadcrumb
    public let message: String?
    
    /// This defines the level of the breadcrumb.
    /// Levels are used in the UI to emphasize and deemphasize the crumb.
    public let level: Severity
    
    /// Data associated with this breadcrumb.
    /// Contains a sub-object whose contents depend on the breadcrumb type.
    /// Additional parameters that are unsupported by the type are rendered as a key/value table.
    public let data: [String: Any]?
    
    
    // MARK: - Instantiation
    
    /// Creates a new `Breadcrumb` object.
    ///
    /// - Parameters:
    ///   - category: A dotted string indicating the crumb location.
    ///   - level: The level of the breadcrumb (defaults to info).
    ///   - message: A message describing the breadcrumb.
    ///   - data: Addition data to be associated to the breadcrumb.
    public init(category: String, level: Severity = .info, message: String? = nil, data: [String: String]? = nil) {
        self.category = category
        self.type = nil
        self.level = level
        self.message = message
        self.data = data
    }
    
    /// Creates a new `Breadcrumb` object.
    ///
    /// - Parameters:
    ///   - type: The type of breadcrumb.
    ///   - level: The level of the breadcrumb (defaults to info).
    ///   - data: Addition data to be associated to the breadcrumb.
    internal init(type: String, level: Severity = .info, data: [String: Any]? = nil) {
        self.category = nil
        self.type = type
        self.level = level
        self.message = nil
        self.data = data
    }
}


// MARK: - Builder Methods Extension

public extension Breadcrumb {
    
    /// Creates a new navigation oriented `Breadcrumb` object.
    ///
    /// Describes a navigation breadcrumb.
    /// This describes a URL change in a web app, a UI transition in a mobile application, etc.
    ///
    /// - Parameters:
    ///   - from: A string representing the original application state / location.
    ///   - to: A string representing the new application state / location.
    public static func makeNavigationBreadcrumb(from: String, to: String) -> Breadcrumb {
        return Breadcrumb(type: "navigation", data: ["from": from, "to": to])
    }
    
    /// Creates a new navigation oriented `Breadcrumb` object.
    ///
    /// Describes an HTTP request breadcrumb.
    /// This represents an HTTP request transmitted from your application.
    ///
    /// This could be an AJAX request from a web application,
    /// or a server-to-server HTTP request to an API service provider, etc.
    ///
    /// - Parameters:
    ///   - url: The request URL.
    ///   - method: The HTTP request method.
    ///   - statusCode: The HTTP status code of the response.
    ///   - reason: A text that describes the status code.
    public static func makeHttpBreadcrumb(url: String, method: String, statusCode: Int, reason: String) -> Breadcrumb {
        return Breadcrumb(type: "http", data: ["url": url, "method": method, "status_code": statusCode, "reason": reason])
    }
}


// MARK: - Serializable Protocol Extension

extension Breadcrumb: Serializable {
    
    /// A request-ready dictionary representation of the `Breadcrumb` struct.
    internal var json: [String: Any] {
        let attributes: [String: Any?] = [
            "timestamp": timestamp,
            "message": message,
            "category": category,
            "type": type,
            "level": level.rawValue,
            "data": data
        ]
        
        return JSON.sanitize(json: attributes.removingNil()) as! [String: Any]
    }
}
