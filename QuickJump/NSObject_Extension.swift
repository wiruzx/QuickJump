//
//  NSObject_Extension.swift
//  QuickJump
//
//  Created by Victor Shamanov on 5/26/15.
//  Copyright (c) 2015 Victor Shamanov. All rights reserved.
//

import Foundation

extension NSObject {
    class func pluginDidLoad(bundle: NSBundle) {
        
        guard let appName = NSBundle.mainBundle().infoDictionary?["CFBundleName"] as? NSString
            where appName == "Xcode" else { return }
        
        guard QuickJump.sharedPlugin == nil else { return }
        
        QuickJump.sharedPlugin = QuickJump(bundle: bundle)
    }
}