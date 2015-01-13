//
//  PlanetView.swift
//  PlanetSwift
//
//  Created by Brad Bambara on 1/13/15.
//  Copyright (c) 2015 Small Planet. All rights reserved.
//

import UIKit

class PlanetView: UIView {
	
	@IBInspectable var xmlPath:String = ""
	var xmlView:View?
	
	//MARK: - UIView override
	
	override func willMoveToSuperview(newSuperview: UIView?) {
		
		loadXMLView()
		
		super.willMoveToSuperview(newSuperview)
	}
	
	//MARK: - loading view
	
	func loadXMLView() {
		
		if xmlView == nil {
			
			let pathExt = xmlPath.pathExtension
			var pathName = xmlPath.lastPathComponent
			pathName = pathName.substringToIndex(advance(pathName.startIndex, (countElements(pathName) - countElements(pathExt))-1))
			
			let path = NSBundle.mainBundle().pathForResource(pathName, ofType: pathExt)
			xmlView = PlanetSwift.PlanetUI.readFromFile(path!) as View?
			xmlView?.loadInto(self)
		}
	}
}
