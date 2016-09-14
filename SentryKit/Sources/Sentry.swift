//
//  Sentry.swift
//  SentryKit
//
//  Created by David Chavez on 2/9/16.
//  Copyright (c) 2016 David Chavez. All rights reserved.
//

import Foundation

public enum SentryError: Error {
    case missingDSN
}

public class Sentry {
    
    /// Returns the shared singleton instance.
    public static let shared = Sentry()
    
    /// Information about the SDK.
    internal static let sdkName = "SentryKit"
    
    /// Trail of events which happened prior to an issue.
    internal var breadcrumbs: [Breadcrumb]?
    
    /// The client's Data Source Name.
    public var dsn: DSN?
    
    /// The client's context storage.
    public let context = Context()
    
    /// Information about the host's app/build/release version.
    public var hostVersion: String?
    
    /// The environment name, such as ‘production’ or ‘staging’.
    public var environment: String?
    
    /// Reports event to Sentry.
    ///
    /// - Parameter message: The message to send to Sentry.
    /// - Parameter level: The severity of the event.
    /// - Parameter tags: Extra tags to include with the event.
    /// - Parameter extra: Extra metadata to include with the event.
    /// - Throws: An error of type `SentryError`
    public func captureMessage(_ message: String, level: Event.Severity = .error, tags: [String: String] = [:], extra: [String: String] = [:]) throws {
        let event = Event(message: message,
                          level: level,
                          context: context,
                          tags: tags,
                          extra: extra)
        
        try send(event: event)
    }
    
    /// Reports error event to Sentry.
    ///
    /// - Parameter message: The message to send to Sentry.
    /// - Parameter culprit: The function call which was the primary perpetrator of this event.
    /// - Parameter exception: The error that occured in the application.
    /// - Parameter tags: Extra tags to include with the event.
    /// - Parameter extra: Extra metadata to include with the event.
    /// - Throws: An error of type `SentryError`
    public func captureError(message: String, culprit: String, exception: Exception, tags: [String: String] = [:], extra: [String: String] = [:]) throws {
        let event = Event(message: message,
                          level: .error,
                          context: context,
                          culprit: culprit,
                          exception: exception,
                          tags: tags,
                          extra: extra)
        
        try send(event: event)
    }
    
    /// Adds a breadcrumb to the breadcrumb trail.
    public func addBreadcrumb(_ breadcrumb: Breadcrumb) {
        if breadcrumbs == nil { breadcrumbs = [] }
        breadcrumbs?.append(breadcrumb)
    }
    
    /// Clears the breadcrumb trail.
    public func clearBreadcrumbs() {
        breadcrumbs = nil
    }
}

internal extension Sentry {
    
    /// Reports an event to Sentry.
    ///
    /// - Parameter event: The event to report to Sentry.
    /// - Throws: An error of type `SentryError` or `JSONSerialization`.
    fileprivate func send(event: Event) throws {
        guard dsn != nil else { throw SentryError.missingDSN }
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let request = try prepareRequest(for: event, usingDSN: dsn!)
        let task = session.dataTask(with: request)
        
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
    /// Prepares a `Request` (headers and body) for reporting an event to Sentry.
    ///
    /// - Parameter for: The event to generate the request for.
    /// - Parameter dsn: The DSN to use for creating the request data.
    /// - Throws: An error of type `JSONSerialization`
    fileprivate func prepareRequest(for event: Event, usingDSN dsn: DSN) throws -> URLRequest {
        let sentryClient = "\(Sentry.sdkName)/\(SentryKitVersionNumber)"
        
        var authHeader: String {
            let components = [
                "Sentry sentry_version": "7",
                "sentry_client": "\(sentryClient)",
                "sentry_timestamp": "\(Date().timeIntervalSince1970)",
                "sentry_key": dsn.publicKey,
                "sentry_secret": dsn.secretKey
            ]
            
            return components
                .map() { "\($0.key)=\($0.value)" }
                .joined(separator: ",")
        }
        
        var request = URLRequest(url: dsn.uri)
        request.httpMethod = "POST"
        request.addValue("\(sentryClient)", forHTTPHeaderField: "User-Agent")
        request.addValue(authHeader, forHTTPHeaderField: "X-Sentry-Auth")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let additionalRequestData: [String: Any?] = [
            "release": hostVersion,
            "environment": environment,
            "breadcrumbs": breadcrumbs?.map() { $0.dict },
            "sdk": ["name": Sentry.sdkName, "version": "\(SentryKitVersionNumber)"]
        ]
        
        let requestData = event.dict + additionalRequestData.filteringNil()
        request.httpBody = try JSONSerialization.data(withJSONObject: requestData, options: [])
        
        return request
    }
}
