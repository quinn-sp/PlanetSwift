//
//  Gaxb.swift
//  PlanetCore
//
//  Created by Quinn McHenry on 7/4/14.
//  Copyright (c) 2014 Small Planet Digital. All rights reserved.
//

import UIKit

public protocol GaxbElement {
    var xmlns: String { get }
	var parent: GaxbElement? { get set }
    func gaxbPrepare()
    func visit(visitor: (GaxbElement) -> ())
	func gaxbDidPrepare()
	func setElement(element: GaxbElement, key:String)
    func setParent(GaxbElement)
    func isKindOfClass(className: String) -> Bool
    func setAttribute(value: String, key:String)
    func imprintAttributes(receiver: GaxbElement?) -> GaxbElement?
    func attributesXML(useOriginalValues:Bool) -> String
    func sequencesXML(useOriginalValues:Bool) -> String
    func toXML(useOriginalValues:Bool) -> String
    func toXML() -> String
    func description() -> String
	func copy() -> GaxbElement
}

public protocol GaxbType {
    init(gaxbString: String)
    mutating func setWithGaxbString(GaxbString: String)
    func toGaxbString() -> String
}

public class GaxbFactory: NSObject {
    public func classWithName(name : String) -> GaxbElement? {
        return nil
    }
    
    public class func factory(namespace: String) -> AnyObject? {
        let className = namespace+"GaxbFactory"
        if let factoryClass = NSClassFromString(className) as? NSObject.Type {
            return factoryClass.init()
        }
        return nil
    }
    
    public class func element(namespace: String, name: String) -> GaxbElement? {
        if let factory = self.factory(namespace) as? GaxbFactory
        {
            return factory.classWithName(name)
        }
        return nil
    }
    
    public class func element(fullname: String) -> GaxbElement? {
        let components = fullname.componentsSeparatedByString(".")
        if (components.count == 2) {
            return self.element(components[0], name: components[1])
        }
        return nil
    }
}

