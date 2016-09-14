//
//  Event.swift
//  SentryKit
//
//  Created by David Chavez on 2/9/16.
//  Copyright (c) 2016 David Chavez. All rights reserved.
//

import Foundation

public struct Event {
    
    // MARK: - Enums
    
    public enum Severity: String {
        case fatal, error, warning, info, debug
    }
    
    
    // MARK: - Attributes
    
    /**
     Hexadecimal string representing a uuid4 value.
     The length is exactly 32 characters (no dashes!)
    */
    internal let id: String = UUID4().hex
    
    /**
     User-readable representation of this event.
     Maximum length is 1000 characters.
    */
    internal let message: String
    
    /**
     The record severity.
     Defaults to error.
     The value needs to be one on the supported level string values.
     */
    internal let level: Severity
    
    /**
     Indicates when the logging record was created (in the Sentry client).
     The Sentry server assumes the time is in UTC.
     The timestamp should be in ISO 8601 format, without a timezone.
    */
    internal let timestamp: String = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        return dateFormatter.string(from: Date())
    }()
    
    /// The authenticated user to associate the event to.
    internal let user: User?
    
    /**
     Function call which was the primary perpetrator of this event.
     Internal Note: This is only visible if exception is also set.
    */
    internal let culprit: String?
    
    /// An error that occured in the application.
    internal let exception: Exception?
    
    /// A dictionary of tags for this event.
    internal let tags: [String: String]
    
    /// A dictionary of of additional metadata to store with the event.
    internal let extra: [String: String]
    
    
    // MARK: - Initializers
    
    internal init(message: String, level: Severity = .error, context: Context, culprit: String? = nil, exception: Exception? = nil, tags: [String: String] = [:], extra: [String: String] = [:]) {
        self.message = message
        self.level = level
        self.user = context.user
        self.culprit = culprit
        self.exception = exception
        self.tags = tags + context.tags
        self.extra = extra + context.extra
    }    
}

internal extension Event {
    /// The request-ready dictionary representation of the `Event` struct.
    internal var dict: [String: Any] {
        // Any value (including embedded collections) should contain only `String` types.
        let attributes: [String: Any?] = [
            "event_id": id,
            "message": message,
            "timestamp": timestamp,
            "level": level.rawValue,
            "platform": "cocoa",
            "user": user?.dict,
            "culprit": culprit,
            "exception": exception == nil ? nil : ["values": [exception!.dict]],
            "tags": tags,
            "extra": extra,
        ]
        
        return attributes.filteringNil()
    }
}
