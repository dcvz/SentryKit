//
//  User.swift
//  SentryKit
//
//  Created by David Chavez on 9/9/16.
//  Copyright © 2016 David Chavez. All rights reserved.
//

import Foundation

/// A struct that describes the authenticated user for a request.
public struct User {
    
    // MARK: - Attributes
    
    /// The unique ID of the user.
    public var id: String = ""
    
    /// The username of the user.
    public var username: String?
    
    /// The email address of the user.
    public var email: String?
    
    /// A dictionary of extra metadata that will be attributed to the user.
    public var extra: [String: Any]?
    
    
    // MARK: - Instantiation
    
    /// Creates a new `User` object.
    ///
    /// - Parameter id: The unique ID of the user.
    /// - Parameter username: The username of the user.
    /// - Parameter email: The email of the user.
    /// - Parameter extra: Additional metadata about the user.
    public init(id: String, username: String? = nil, email: String? = nil, extra: [String: Any]? = nil) {
        self.id = id
        self.username = username
        self.email = email
        self.extra = extra
    }
}


// MARK: - Serializable Protocol Extension

extension User: Serializable {
    
    /// A request-ready dictionary representation of the `User` struct.
    internal var json: [String: Any] {
        let attributes: [String: Any?] = [
            "id": id,
            "email": email,
            "username": username,
            "extra": extra
        ]
        
        return JSON.sanitize(json: attributes.removingNil()) as! [String: Any]
    }
}
