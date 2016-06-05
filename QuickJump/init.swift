//
//  init.swift
//  QuickJump
//
//  Created by Victor Shamanov on 06.06.16.
//  Copyright © 2016 Victor Shamanov. All rights reserved.
//

import Foundation

private var plugin: QuickJump?

private extension NSObject {
    @objc class func pluginDidLoad(bundle: NSBundle) {
        
        guard plugin == nil,
            let appName = NSBundle.mainBundle().infoDictionary?["CFBundleName"] as? NSString
            where appName == "Xcode" else { return }
        
        plugin = QuickJump(bundle: bundle)
    }
}
