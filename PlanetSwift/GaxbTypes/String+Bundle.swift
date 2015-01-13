//
//  String+Bundle.swift
//  PlanetSwift
//
//  Created by Brad Bambara on 1/13/15.
//  Copyright (c) 2015 Small Planet. All rights reserved.
//

import Foundation

extension String {
	
	public init(bundlePath:String) {
		self.init()
		
		if let resourcePath = NSBundle.mainBundle().resourcePath {
			if bundlePath.hasPrefix("bundle:/") {
				self = resourcePath.stringByAppendingPathComponent(bundlePath.substringFromIndex(advance(bundlePath.startIndex, 8)))
				return
			}
		}
		self = bundlePath
	}
	
}