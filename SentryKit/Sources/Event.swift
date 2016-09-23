//
//  Event.swift
//  SentryKit
//
//  Created by David Chavez on 2/9/16.
//  Copyright (c) 2016 David Chavez. All rights reserved.
//

import Foundation

/// A struct that describes an event to be reported.
public struct Event {
    
    // MARK: - Enums
    
    /// Denotes the severity level of an event.
    public enum Severity: String {
        case fatal, error, warning, info, debug
    }
    
    
    // MARK: - Attributes
    
    /// Hexadecimal string representing a uuid4 value.
    /// The length is exactly 32 characters (no dashes or spaces).
    internal let id: String = UUID().uuidString.replacingOccurrences(of: "-", with: "")
    
    /// User-readable representation of this event.
    /// Maximum length is 1000 characters.
    internal let message: String
    
    /// The event severity.
    /// The value needs to be one on the supported level string values.
    internal let level: Severity
    
    /// Indicates when the logging record was created (in the Sentry client).
    /// The Sentry server assumes the time is in UTC.
    /// The timestamp should be in ISO 8601 format, without a timezone.
    internal let timestamp: String = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        return dateFormatter.string(from: Date())
    }()
    
    /// The authenticated user to associate the event to.
    internal let user: User?
    
    /// Function call which was the primary perpetrator of this event.
    /// - Note: This is only visible if exception is also set.
    internal let culprit: String?
    
    /// An error that occured in the application.
    internal let exception: Exception?
    
    /// A dictionary of tags for this event.
    internal let tags: [String: Any]?
    
    /// A dictionary of of additional metadata to store with the event.
    internal let extra: [String: Any]?
    
    
    // MARK: - Instantiation
    
    /// Creates a new `Event` object.
    ///
    /// - Parameters:
    ///   - message: A user-readable representation of this event.
    ///   - level: The severity of the event (defaults to error).
    ///   - context: The global context to attach to events.
    ///   - culprit: The function call which was the primary perpetrator of the event.
    ///   - exception: The error that occured.
    ///   - tags: Additional tags to attach to the event.
    ///   - extra: Additional metadata to attach to the event.
    internal init(message: String, level: Severity = .error, context: Context, culprit: String? = nil, exception: Exception? = nil, tags: [String: Any]? = nil, extra: [String: Any]? = nil) {
        self.message = message
        self.level = level
        self.user = context.user
        self.culprit = culprit
        self.exception = exception
        self.tags = tags + context.tags
        self.extra = extra + context.extra
    }    
}


// MARK: - Serializable Protocol Extension

extension Event: Serializable {
    
    /// A request-ready dictionary representation of the `Event` struct.
    internal var json: [String: Any] {
        let attributes: [String: Any?] = [
            "event_id": id,
            "message": message,
            "timestamp": timestamp,
            "level": level.rawValue,
            "platform": "cocoa",
            "user": user?.json,
            "culprit": culprit,
            "exception": exception == nil ? nil : ["values": [exception!.json]],
            "tags": tags,
            "extra": extra,
        ]
        
        return JSON.sanitize(json: attributes.removingNil()) as! [String: Any]
    }
}
