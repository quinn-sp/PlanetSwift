//
//  PlanetViewController.swift
//  PlanetSwift
//
//  Created by Brad Bambara on 1/21/15.
//  Copyright (c) 2015 Small Planet. All rights reserved.
//

import UIKit

public class PlanetViewController: UIViewController {
	
	var planetViews = Array<PlanetView>()
	var idMappings = Dictionary<String, Object>()
	
	public override func loadView() {
		super.loadView()
		
		//overriding loadView because we need a function where the view exists, but child view controllers have not been loaded yet
		searchForPlanetView(self.view)
		for planetView in planetViews {
			if let xmlObj = planetView.xmlView {
				xmlObj.visit({ [unowned self] (element:GaxbElement) -> () in
					
					if let xmlController = element as? Controller {
						xmlController.controllerObject = self
					}
					
					if let xmlObject = element as? Object {
						
						if xmlObject.id != nil {
							self.idMappings[xmlObject.id!] = xmlObject
						}
					}
				})
			}
		}
	}
	
	func searchForPlanetView(searchedView:UIView) {
		if let foundView = searchedView as? PlanetView {
			planetViews.append(foundView)
		}
		for child in searchedView.subviews {
			searchForPlanetView(child as UIView)
		}
	}
	
	public func objectForId<T>(id:String) -> T? {
		if let foundObj = idMappings[id] as? T {
			return foundObj
		}
		return nil
	}
	
}
