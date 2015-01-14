//
//  PlanetView.swift
//  PlanetSwift
//
//  Created by Brad Bambara on 1/13/15.
//  Copyright (c) 2015 Small Planet. All rights reserved.
//

import UIKit

class PlanetView: UIView {
	
	var xmlView:View?
	@IBInspectable var bundlePath:String? {
		didSet {
			loadXMLView()
		}
	}
	
	//MARK: - loading view
	
	func loadXMLView() {
		
		if xmlView == nil && bundlePath != nil {
			
			xmlView = PlanetSwift.PlanetUI.readFromFile(String(bundlePath: self.bundlePath!)) as View?
			xmlView?.loadInto(self)
		}
	}
}
