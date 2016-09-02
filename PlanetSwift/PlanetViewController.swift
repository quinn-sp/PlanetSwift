//
//  PlanetViewController.swift
//  PlanetSwift
//
//  Created by Brad Bambara on 1/21/15.
//  Copyright (c) 2015 Small Planet. All rights reserved.
//

import UIKit

public class PlanetViewController: UIViewController {
	
    public var planetViews = Array<PlanetView>()
	var idMappings = Dictionary<String, Object>()
	@IBInspectable public var titleBundlePath: String?
    public var mainBundlePath: String?
    
    public var titleXmlView: View?
    public var mainXmlView: View?
	
	public override func loadView() {
		super.loadView()
		
        navigationItem.title = self.title
		
		if let titleBundlePath = titleBundlePath, titleXmlView = PlanetUI.readFromFile(String(bundlePath: titleBundlePath)) as? View {
            navigationItem.titleView = titleXmlView.view
            titleXmlView.visit { $0.gaxbDidPrepare() }
            searchXMLObject(titleXmlView)
            self.titleXmlView = titleXmlView
		}
		
        if let mainBundlePath = mainBundlePath, mainXmlView = PlanetUI.readFromFile(String(bundlePath: mainBundlePath)) as? View {
            view.addSubview(mainXmlView.view)
            mainXmlView.visit { $0.gaxbDidPrepare() }
            searchXMLObject(mainXmlView)
            self.mainXmlView = mainXmlView
        }
        
		// Overriding loadView because we need a function where the view exists
        // but child view controllers have not been loaded yet
		searchForPlanetView(view)
		for planetView in planetViews {
			if let xmlObj = planetView.xmlView {
				searchXMLObject(xmlObj)
                xmlObj.visit(decorate)
			}
		}
	}
	
	func searchXMLObject(xmlObj:Object) {
		xmlObj.visit{ [unowned self] (element:GaxbElement) -> () in
			if let xmlController = element as? Controller {
				xmlController.controllerObject = self
			}
			if let xmlObject = element as? Object, objectId = xmlObject.id {
                self.idMappings[objectId] = xmlObject
			}
		}
	}
    
    public func decorate(element: GaxbElement) {
        // Override decorate in your controller class if you need a 
        // handle on the XML views from your PlanetView
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
        guard let foundObj = idMappings[id] as? T else { return nil }
        return foundObj
	}
	
}
