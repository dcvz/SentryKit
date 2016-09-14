//
//  Serializable.swift
//  SentryKit
//
//  Created by David Chavez on 9/14/16.
//  Copyright © 2016 David Chavez. All rights reserved.
//

import Foundation

/// A type that provides a request-ready dictionary representation of self.
internal protocol Serializable {
    
    /// - Note: Any value (including embedded collections) should contain only primitive types.
    var dict: [String: Any] { get }
}
