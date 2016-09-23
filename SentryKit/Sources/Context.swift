//
//  Context.swift
//  SentryKit
//
//  Created by David Chavez on 9/9/16.
//  Copyright © 2016 David Chavez. All rights reserved.
//

import Foundation


/// A struct that describes additional context data to reported events.
///
/// This is typically data related to the current user.
public class Context {
    
    // MARK: - Attributes
    
    /// The authenticated user to associate events to.
    public var user: User?
    
    /// A dictionary of tags that will be applied to every reported event.
    public var tags: [String: Any]? = nil
    
    /// A dictionary of metadata that will be applied to every reported event.
    public var extra: [String: Any]? = nil
    
    
    // MARK: - Public Interface
    
    /// Clears the context for future events.
    public func clear() {
        user = nil
        tags = nil
        extra = nil
    }
}
