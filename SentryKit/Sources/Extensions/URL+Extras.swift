//
//  URL+Extras.swift
//  SentryKit
//
//  Created by David Chavez on 11/9/16.
//  Copyright © 2016 David Chavez. All rights reserved.
//

import Foundation

internal extension URL {
    
    /// Returns a URL constructed by appending the given path components to self.
    internal func appendingPathComponents(_ pathComponents: [String]) -> URL {
        return pathComponents.reduce(self) { $0.appendingPathComponent($1) }
    }
}
