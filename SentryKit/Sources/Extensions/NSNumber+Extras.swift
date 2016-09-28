//
//  NSNumber+Extras.swift
//  SentryKit
//
//  Created by David Chavez on 23/9/16.
//  Copyright © 2016 David Chavez. All rights reserved.
//

import Foundation

extension NSNumber {
    
    /// Returns wether it is representing a `Bool` value.
    var isBool: Bool {
        return CFBooleanGetTypeID() == CFGetTypeID(self)
    }
}
