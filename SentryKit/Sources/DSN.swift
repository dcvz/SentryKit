//
//  DSN.swift
//  SentryKit
//
//  Created by David Chavez on 2/9/16.
//  Copyright (c) 2016 David Chavez. All rights reserved.
//

import UIKit

public enum DSNError: Error {
    case invalid
}

/// A type representing the Data Source Name.
public struct DSN {
    
    // MARK: - Attributes
    
    /// The hostname of the Sentry server.
    public let host: URL
    
    /// The public key to authenticate the user.
    public let publicKey: String
    
    /// The private key to authenticate the user.
    internal let secretKey: String
    
    /// The project ID which the authenticated user is bound to.
    public let projectID: String
    
    /// The request endpoint URI of the Sentry server.
    internal let uri: URL
    
    
    // MARK: - Instantiation
    
    /// Creates a new `DSN` object from the given DSN string.
    ///
    /// A DSN consists of five parts:
    /// protocol, public and secret keys, hostname and project ID.
    ///
    /// - Parameter dsn: A string denoting the Data Source Name.
    /// - Throws: An error of type `DSNError`
    public init(dsn: String) throws {
        guard
            let url = URL(string: dsn),
            let scheme = url.scheme,
            let hostname = url.host,
            let publicKey = url.user,
            let secretKey = url.password
        else { throw DSNError.invalid }
        
        var components = URLComponents()
        components.host = hostname
        components.scheme = scheme
        
        guard let host = components.url else { throw DSNError.invalid }
        
        self.publicKey = publicKey
        self.secretKey = secretKey
        self.host = host
        self.projectID = url.path.replacingOccurrences(of: "/", with: "")
        self.uri = host.appendingPathComponents(["api", projectID, "store/"])
    }
}
