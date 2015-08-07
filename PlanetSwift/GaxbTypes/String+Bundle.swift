//
//  String+Bundle.swift
//  PlanetSwift
//
//  Created by Brad Bambara on 1/13/15.
//  Copyright (c) 2015 Small Planet. All rights reserved.
//

import UIKit
import Foundation

extension String {
	
	public init(bundlePath:String) {
		self.init()
        let pathComponents = bundlePath.componentsSeparatedByString(":/")
        switch pathComponents[0] {
        case "bundle":
            if let resourcePath = NSBundle.mainBundle().resourcePath {
                self = NSString(string: resourcePath).stringByAppendingPathComponent(pathComponents[1])
            }
        case "documents":
            let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
            self = NSString(string: documentsPath).stringByAppendingPathComponent(pathComponents[1])
        case "cache":
            let cachePath = NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true)[0]
            self = NSString(string: cachePath).stringByAppendingPathComponent(pathComponents[1])
        default:
            self = bundlePath
        }
	}
	
}