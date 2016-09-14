//
//  Dictionary+Extras.swift
//  SentryKit
//
//  Created by David Chavez on 12/9/16.
//  Copyright © 2016 David Chavez. All rights reserved.
//

import Foundation

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
    internal func filteringNil() -> [Key: Any] {
        return self.reduce([:]) { original, pair in
            var copy = original
            
            if let value = pair.value.asOptional {
                copy[pair.key] = value
            }
            
            return copy
        }
    }
}

/// Adds two dictionaries, with priority on right hand keys
func + <K, V> (left: [K: V], right: [K: V]) -> [K: V] {
    var ret: [K: V] = [:]
    
    for (k, v) in left {
        ret.updateValue(v, forKey: k)
    }
    
    for (k, v) in right {
        ret.updateValue(v, forKey: k)
    }
    
    return ret
}
