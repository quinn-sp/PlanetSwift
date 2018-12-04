//
//  PlanetViewController.swift
//  PlanetSwift
//
//  Created by Brad Bambara on 1/21/15.
//  Copyright (c) 2015 Small Planet. All rights reserved.
//

import UIKit

open class PlanetViewController: UIViewController {
    
    open var planetViews = Array<PlanetView>()
    var idMappings = Dictionary<String, Object>()
    @IBInspectable open var titleBundlePath: String?
    open var mainBundlePath: String?
    open var navigationBarHidden = false
    
    open var titleXmlView: View?
    open var mainXmlView: View?
    
    open override func loadView() {
        super.loadView()
        
        navigationItem.title = self.title
        
        if let titleBundlePath = titleBundlePath, let titleXmlView = PlanetUI.readFromFile(String(bundlePath: titleBundlePath)) as? View {
            navigationItem.titleView = titleXmlView.view
            titleXmlView.visit { $0.gaxbDidPrepare() }
            searchXMLObject(titleXmlView)
            self.titleXmlView = titleXmlView
        }
        
        if let mainBundlePath = mainBundlePath, let mainXmlView = PlanetUI.readFromFile(String(bundlePath: mainBundlePath)) as? View {
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
    
    func searchXMLObject(_ xmlObj: Object) {
        xmlObj.visit { [unowned self] (element:GaxbElement) -> () in
            if let xmlController = element as? Controller {
                xmlController.controllerObject = self
            }
            if let xmlObject = element as? Object, let objectId = xmlObject.id {
                self.idMappings[objectId] = xmlObject
            }
        }
    }
    
    open func decorate(_ element: GaxbElement) {
        // Override decorate in your controller class if you need a
        // handle on the XML views from your PlanetView
    }
    
    func searchForPlanetView(_ searchedView:UIView) {
        if let foundView = searchedView as? PlanetView {
            planetViews.append(foundView)
        }
        for child in searchedView.subviews {
            searchForPlanetView(child as UIView)
        }
    }
    
    open func objectForId<T>(_ id:String) -> T? {
        guard let foundObj = idMappings[id] as? T else { return nil }
        return foundObj
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if navigationBarHidden {
            navigationController?.setNavigationBarHidden(true, animated: true)
        }
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        if navigationBarHidden {
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
    
}
