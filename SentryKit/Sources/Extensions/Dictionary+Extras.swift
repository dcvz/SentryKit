//
//  Dictionary+Extras.swift
//  SentryKit
//
//  Created by David Chavez on 12/9/16.
//  Copyright © 2016 David Chavez. All rights reserved.
//

import Foundation

/// Adds two dictionaries. It will prioritize
/// the right hand keys if both sides are non-nil.
/// - Parameters:
///   - lhs: The left-hand side of the operation.
///   - rhs: The right-hand side of the operation.
internal func + <T, U>(lhs: [T: U]?, rhs: [T: U]?) -> [T: U]? {
    if lhs == nil && rhs == nil { return nil }
    else if lhs == nil { return rhs }
    else if rhs == nil { return lhs }
    
    var merged = lhs!
    for (key, val) in rhs! {
        merged[key] = val
    }
    
    return merged
}

internal extension Dictionary {
    
    /// Returns a dictionary containing the results of mapping the given closure
    /// over the dictionary's values.
    ///
    /// - Parameter transform: A mapping closure. `transform` accepts a
    ///   value of this dictionary as its parameter and returns a transformed
    ///   value of the same or of a different type.
    /// - Returns: A dictionary containing the transformed values of this
    ///   dictionary.
    internal func map<T>(_ transform: (Value) throws -> T) rethrows -> [Key: T] {
        var accum = Dictionary<Key, T>(minimumCapacity: self.count)
        
        for (key, value) in self {
            accum[key] = try transform(value)
        }
        
        return accum
    }
}

internal protocol OptionalType {
    associatedtype Wrapped
    var asOptional : Wrapped? { get }
}

extension Optional : OptionalType {
    var asOptional : Wrapped? {
        return self
    }
}

internal extension Dictionary where Value: OptionalType {
    
    
    /// Removes any `nil` values from the dictionary.
    ///
    /// - Returns: A dictionary that doesn't contain nil values.
    internal func removingNil() -> [Key: Any] {
        return self.reduce([:]) { original, pair in
            var copy = original
            
            if let value = pair.value.asOptional {
                copy[pair.key] = value
            }
            
            return copy
        }
    }
}
