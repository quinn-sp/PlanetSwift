//
//  String+Bundle.swift
//  PlanetSwift
//
//  Created by Brad Bambara on 1/13/15.
//  Copyright (c) 2015 Small Planet. All rights reserved.
//

import UIKit

extension String {
	
	public init(bundlePath:String) {
		self.init()
        let pathComponents = bundlePath.componentsSeparatedByString(":/")
        switch pathComponents[0] {
        case "bundle":
            if let resourcePath = NSBundle.mainBundle().resourcePath {
                self = resourcePath.stringByAppendingPathComponent(pathComponents[1])
            }
        case "documents":
            if let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as? NSString {
                self = documentsPath.stringByAppendingPathComponent(pathComponents[1])
            }
        case "cache":
            if let cachePath = NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true)[0] as? NSString {
                self = cachePath.stringByAppendingPathComponent(pathComponents[1])
            }
        default:
            self = bundlePath
        }
	}
	
}