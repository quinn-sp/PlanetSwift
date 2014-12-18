//
//  PlanetSwiftLabelTests.swift
//  PlanetSwift
//
//  Created by Quinn McHenry on 12/17/14.
//  Copyright (c) 2014 Small Planet. All rights reserved.
//

import UIKit
import PlanetSwift
import XCTest

class PlanetSwiftLabelTests: XCTestCase {
    let testXMLString = "<View xmlns='http://schema.smallplanet.com/PlanetSwift' frame='0.0,0.0,768.0,1024.0' title='scene'><Label text='Some text' fontName='Avenir-Light' fontSize='20.00000' textColor='#FF0000FF' textAlignment='Center' minimumScaleFactor='0.00000' numberOfLines='2' frame='0.0,300.0,320.0,100.0' color='#2266FF22'/><Label text='A very very very very Merry Swiftmas!' fontName='Avenir-Light' fontSize='20.00000' textColor='#FF0000FF' adjustsFontSizeToFitWidth='true' minimumScaleFactor='0.00000' numberOfLines='1' frame='50.0,400.0,240.0,100.0'/></View>"
    var element: GaxbElement?
    var label0: Label?
    var label1: Label?
    
    override func setUp() {
        super.setUp()
        element = PlanetSwift.readFromString(testXMLString)
        if let view = element as View? {
            if let label = view.views[0] as? Label {
                label0 = label
            }
            if let label = view.views[1] as? Label {
                label1 = label
            }
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testLabelsParse() {
        // This is an example of a functional test case.
        XCTAssert(label0 != nil, "Label #0 is nil")
        XCTAssert(label1 != nil, "Label #1 is nil")
    }
    
    func testLabelViews() {
        XCTAssert(label0!.label.isKindOfClass(UILabel), "label0 does not have a UILabel")
        XCTAssert(label1!.label.isKindOfClass(UILabel), "label1 does not have a UILabel")
    }
    
    func testLabelTextAlignmentEnum() {
        XCTAssertEqual(PlanetSwift.textAlignment.Center.rawValue, "Center", "TextAlignment enum Center invalid")
        XCTAssertEqual(PlanetSwift.textAlignment.Left.rawValue, "Left", "TextAlignment enum Left invalid")
        XCTAssertEqual(PlanetSwift.textAlignment.Right.rawValue, "Right", "TextAlignment enum Right invalid")
        XCTAssertEqual(PlanetSwift.textAlignment.Justified.rawValue, "Justified", "TextAlignment enum Justified invalid")
        XCTAssertEqual(PlanetSwift.textAlignment.Natural.rawValue, "Natural", "TextAlignment enum Natural invalid")
    }

}
