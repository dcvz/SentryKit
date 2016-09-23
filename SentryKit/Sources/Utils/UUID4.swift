//
//  UUID4.swift
//  SentryKit
//
//  Created by David Chavez on 2/9/16.
//  Copyright (c) 2016 David Chavez. All rights reserved.
//

import Foundation

/// A struct denoting a randomly created UUID.
internal struct UUID4 {
    
    // MARK: - Attributes
    
    /// The individual bytes that make up the UUID.
    private var bytes:[UInt8]!
    
    /// The hexadecimal string representation of the uuid4 value.
    /// The length is exactly 32 characters (no dashes or spaces).
    internal var hex: String {
        return bytes.reduce("") { $0 + String(format:"%2X", $1) }
    }
    
    
    // MARK: - Instantiation
    
    /// Creates a new `UUID4` object.
    internal init() {
        self.bytes = [UInt8](repeating: 0, count: 16)
        for i in 0..<16 {
            self.bytes[i] = UInt8(arc4random_uniform(256))
        }
        self.bytes[6] = self.bytes[6] & 0x0f + 0x40
        self.bytes[8] = self.bytes[8] & 0x3f + 0x80
    }
}
