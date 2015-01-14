//
//  PlanetView.swift
//  PlanetSwift
//
//  Created by Brad Bambara on 1/13/15.
//  Copyright (c) 2015 Small Planet. All rights reserved.
//

import UIKit

class PlanetView: UIView {
	
	@IBInspectable var bundlePath:String?
	var xmlView:View?
	
	//MARK: - UIView override
	
	override func willMoveToSuperview(newSuperview: UIView?) {
		
		loadXMLView()
		
		super.willMoveToSuperview(newSuperview)
	}
	
	//MARK: - loading view
	
	func loadXMLView() {
		
		if xmlView == nil && bundlePath != nil {
			
			xmlView = PlanetSwift.PlanetUI.readFromFile(String(bundlePath: self.bundlePath!)) as View?
			xmlView?.loadInto(self)
		}
	}
}
