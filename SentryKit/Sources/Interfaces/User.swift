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
    public var extra: [String: String] = [:]
    
    
    // MARK: - Initializers
    
    public init(id: String, username: String? = nil, email: String? = nil, extra: [String: String] = [:]) {
        self.id = id
        self.username = username
        self.email = email
        self.extra = extra
    }
}

internal extension User {
    /// The request-ready dictionary representation of the `User` struct.
    internal var dict: [String: Any] {
        // Any value (including embedded collections) should contain only `String` types.
        let attributes: [String: Any?] = [
            "id": id,
            "email": email,
            "username": username,
            "extra": extra
        ]
        
        return attributes.filteringNil()
    }
}
