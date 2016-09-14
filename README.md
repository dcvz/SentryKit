# SentryKit

![platforms](https://img.shields.io/badge/platform-iOS-lightgrey.svg) ![pod](https://img.shields.io/badge/pod-v0.1.0-red.svg) [![social](https://img.shields.io/badge/twitter-%40dchavezlive-blue.svg)](https://twitter.com/dchavezlive)

A client for the [Sentry](https://github.com/getsentry/sentry) error reporting API written in Swift.

## Requirements

- iOS 8.0+
- Xcode 8.0+
- Swift 3.0+

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

> CocoaPods 1.1.0+ is required to build SentryKit 0.1.0+.

To integrate SentryKit into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'SentryKit', '~> 0.1.0'
end
```

Then, run the following command:

```bash
$ pod install
```

## Usage

### Configuring the Client

```swift
let client = Sentry.shared

do {
    // create a DSN object from your DSN string (found in Sentry panel).
    let dsn = try DSN(dsn: "https://public:secret@dcvz.io/1")
    
    // configure the shared client with the DSN
    client.dsn = dsn
} catch {
    // handle error
}

// other attributes you may set at start or when they become available
client.hostVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
client.environment = "production"

// the context allows you to store general information to include with requests
// i.e. tags, extra metadata, and user information (more info in Xcode)
client.context.tags = ["customer_tier": "pro"]
client.context.extra = ["advertising_group": "alucard"]

// you should set this attribute of context when a user authenticates
client.context.user = User(id:username:email:extra)

```

### Capture Messages
You may capture messages using the `captureMessage(message:level:tags:extra:)` method in the client.
```swift
do {
    try client.captureMessage("This is a test message", level: .info)
} catch {
    // handle error gracefully
}
```

### Capture Error
You may capture errors using the `captureError(message:culprit:exception:tags:extra)` method in the client.
```swift
// the `Exception` struct is used to represent an error (i.e.)
// init signature: Exception(value:type:module)
let exception = Exception(value: "did fail to test", type: "NSTestDomain")

do {
    try client.captureError(message: "This is a test error", culprit: "didTest() in Test.swift:12", exception: exception)
} catch {
    // handle error gracefully
}
```

### Breadcrumbs
Sentry supports a concept called Breadcrumbs, which is a trail of events which happened prior to an issue.
```swift
// create a generic breadcrumb
let readBC = Breadcrumb(category: "user.action", level: .info, message: "User read README")
client.addBreadcrumb(readBC)

// sentry supports two types of specialized breadcrumbs a `navigation` and `http`
// there's two build methods that will allow you to create those correctly

// this describes a URL change in a web app, a UI transition in a mobile application, etc.
let navBC = Breadcrumb.navigationBreadcrumb(from: "launch", to: "firstViewController")
client.addBreadcrumb(navBC)

// this represents an HTTP request transmitted from your application.
let requestBC = Breadcrumb.Breadcrumb.httpBreadcrumb(url: "http://dcvz.io", method: "GET", statusCode: 200, reason: "OK")
client.addBreadcrumb(requestBC)

// you may also clear breadcrumbs
client.clearBreadcrumbs()
```

## Communication

- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.

You can also find me on Twitter: [@dchavezlive](https://twitter.com/dchavezlive)

## License

SentryKit is released under the MIT license. See LICENSE for details
