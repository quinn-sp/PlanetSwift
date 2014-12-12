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

