//
//  Gaxb.swift
//  PlanetCore
//
//  Created by Quinn McHenry on 7/4/14.
//  Copyright (c) 2014 Small Planet Digital. All rights reserved.
//

import UIKit

public protocol GaxbElement {
    var parent: GaxbElement? { get }
    var xmlns: String { get }
    func setElement(element: GaxbElement, key:String)
    func setAttribute(value: String, key:String)
    func attributesXML(useOriginalValues:Bool) -> String
    func sequencesXML(useOriginalValues:Bool) -> String
    func toXML(useOriginalValues:Bool) -> String
    func toXML() -> String
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
            return factoryClass()
        }
        return nil
    }
}