//
//  PlanetSwiftTests.swift
//  PlanetSwiftTests
//
//  Created by Quinn McHenry on 12/11/14.
//  Copyright (c) 2014 Small Planet. All rights reserved.
//

import UIKit
import XCTest
import PlanetSwift

class PlanetSwiftTests: XCTestCase {
    let testXMLString = "<View xmlns='http://schema.smallplanet.com/PlanetSwift' frame='100.0,66.5,200.0,190.0' color='#FF8040FF' clipsToBounds='true' title='something'><View frame='120.0,100.0,30.0,30.0' color='#C8EA00FF' alpha='1.00000' clipsToBounds='false'/><View frame='-50.0,10.0,80.0,80.0' color='#2266FF88' hidden='false' clipsToBounds='false' tag='3'/></View>"
    var element: GaxbElement?
    
    override func setUp() {
        super.setUp()
        element = PlanetSwift.readFromString(testXMLString)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testParse() {
        XCTAssert(element != nil, "Parsed element is nil")
    }
    
    func testView() {
        XCTAssert(element is View, "element is not a View")
    }
    
    func testUIView() {
        if let view = element as? View {
            XCTAssert(view.view.isKindOfClass(UIView), "element.view is not a UIView")
        }
    }

    func testSubviews() {
        if let view = element as? View {
            XCTAssertEqual(view.views.count, 2, "Subviews count should be 2")
        }
    }
    
    func testViewFrame() {
        if let view = element as? View {
            XCTAssertEqual(view.view.frame.origin.x, CGFloat(100.0), "view frame origin x should be 100.0")
            XCTAssertEqual(view.view.frame.origin.y, CGFloat(66.5), "view frame origin y should be 66.5")
            XCTAssertEqual(view.view.frame.size.width, CGFloat(200.0), "view frame width should be 200.0")
            XCTAssertEqual(view.view.frame.size.height, CGFloat(190.0), "view frame height should be 190.0")
        }
    }
    
    func testViewColor() {
        if let view = element as? View {
            XCTAssertNotNil(view.color, "view.color is nil")
            if let color = view.color {
                var (r,g,b,a): (CGFloat, CGFloat, CGFloat, CGFloat) = (-1.0, -1.0, -1.0,-1.0)
                color.getRed(&r, green:&g , blue: &b, alpha: &a)
                XCTAssertEqual(r, CGFloat(1.0), "Color's red is incorrect")
                XCTAssertEqual(g, CGFloat(0x80/255.0), "Color's green is incorrect")
                XCTAssertEqual(b, CGFloat(0x40/255.0), "Color's blue is incorrect")
                XCTAssertEqual(a, CGFloat(1.0), "Color's alpha is incorrect")
            }
        }
    }
    
    func testViewClipsToBounds() {
        if let view = element as? View {
            XCTAssertTrue(view.clipsToBounds == true, "element clipsToBounds should be true")
            XCTAssertTrue(view.view.clipsToBounds == true, "element.view clipsToBounds should be true")
        }
    }
    
    func testObjectTitle() {
        if let view = element as? View {
            XCTAssertEqual(view.title!, "something", "Object.title not correct")
        }
    }
    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measureBlock() {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
}
