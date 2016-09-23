//
//  JSON.swift
//  SentryKit
//
//  Created by David Chavez on 22/9/16.
//  Copyright © 2016 David Chavez. All rights reserved.
//

import Foundation

/// Serves as a namespace for JSON related helpers.
internal enum JSON {
    
    /// Sanitizes an object into a representation that can be
    /// validly converted to JSON data using JSONSerialization.
    ///
    /// - Parameter json: the JSON object to sanitize.
    /// - Returns: An object that can be succesfully converted to JSON data.
    static func sanitize(json: Any) -> Any {
        switch json {
        case let v as [Any]:
            return v.map(JSON.sanitize)
        case let v as [String: Any]:
            return v.map(JSON.sanitize)
        case let v as String:
            return v
        case let v as NSURL:
            return v.absoluteString!
        case let v as NSNumber:
            if v.isBool {
                return v as Bool
            } else {
                return v
            }
        default:
            return "\(json)"
        }
    }
}
