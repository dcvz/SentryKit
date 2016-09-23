//
//  ViewController.swift
//  SentryKitExample
//
//  Created by David Chavez on 9/9/16.
//  Copyright © 2016 David Chavez. All rights reserved.
//

import UIKit
import SentryKit

class ViewController: UIViewController {
    
    // MARK: - Attributes
    
    private var client = Sentry.shared
    
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loadi
        
        // Setup Sentry
        let dsn = try! DSN(dsn: "https://public:secret@dcvz.io/1")
        client.dsn = dsn
        client.hostVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        client.environment = "testing"
        
        let user = User(id: "test-id")
        client.context.user = user
        client.context.user?.extra = ["age": 22]
        client.context.tags = ["jailbroken": true]
        client.context.extra = ["test-extra": "value"]
        
        // Add first breadcrumb
        let viewedBC = Breadcrumb.navigationBreadcrumb(from: "Launch", to: "\(type(of: self))")
        client.addBreadcrumb(viewedBC)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - IBActions
    
    @IBAction func reportError(_ sender: AnyObject) {
        let reportBC = Breadcrumb(category: "user.action", level: .info, message: "User reported error")
        client.addBreadcrumb(reportBC)
        
        let exception = Exception(value: "did fail to test", type: "NSTestDomain")
        try! client.captureError(message: "This is a test error", culprit: "didTest() in Test.swift:12", exception: exception)
    }
    
    @IBAction func reportMessage(_ sender: AnyObject) {
        let reportBC = Breadcrumb(category: "user.action", level: .info, message: "User reported message")
        client.addBreadcrumb(reportBC)
        
        try! client.captureMessage("This is a test message", level: .info)
    }
}
