//
//  Gaxb.swift
//  Copyright (c) 2014 Small Planet. All rights reserved.
//

import UIKit


extension CGRect: GaxbType {
    public init(gaxbString withGaxbString: String) {
        let (origin, size) = CGRect.componentsFromString(withGaxbString)
        self.init(origin: origin, size: size)
    }
    public mutating func setWithGaxbString(GaxbString: String) {
        var (newOrigin, newSize) = CGRect.componentsFromString(GaxbString)
        origin = newOrigin
        size = newSize
    }
    public func toGaxbString() -> String {
        return "\(origin.x),\(origin.y),\(size.width),\(size.height)"
    }
    public static func componentsFromString(string: String) -> (CGPoint, CGSize) {
        var x=0, y=0, w=0, h=0
        var components = string.componentsSeparatedByString(",")
        if components.count == 4 {
            x = components[0].toInt()!
            y = components[1].toInt()!
            w = components[2].toInt()!
            h = components[3].toInt()!
        }
        let origin = CGPoint(x: x, y: y)
        let size = CGSize(width: w, height: h)
        return (origin, size)
    }
}

extension UIImage {
    convenience init?(validateAndLoad name: String!) {
        self.init(named: name)
        
        // need to assert here if self.init fails
    }
}

extension Bool: GaxbType {
    public init(gaxbString: String) {
        self.init()
        self.setWithGaxbString(gaxbString)
    }
    public mutating func setWithGaxbString(gaxbString: String) {
        switch gaxbString {
            case "true": self = true
            default: self = false
        }
    }
    public func toGaxbString() -> String {
        return self ? "true" : "false"
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int)
    {
        let newRed   = CGFloat(Double(red) / 255.0)
        let newGreen = CGFloat(Double(green) / 255.0)
        let newBlue  = CGFloat(Double(blue) / 255.0)
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: CGFloat(1.0))
    }

    convenience init(gaxbString: String) {
        var (r,g,b,a): (CGFloat, CGFloat, CGFloat, CGFloat) = (0.0, 0.0, 0.0, 1.0)
        if gaxbString.hasPrefix("#") {
            let substring = gaxbString.substringFromIndex(advance(gaxbString.startIndex, 1))
            var hexNumber:UInt32 = 0;
            let hexScanner = NSScanner(string: substring).scanHexInt(&hexNumber)
            switch countElements(substring) {
            case 8:
                r = CGFloat((hexNumber & 0xFF000000) >> 24) / 255.0
                g = CGFloat((hexNumber & 0x00FF0000) >> 16) / 255.0
                b = CGFloat((hexNumber & 0x0000FF00) >> 8) / 255.0
                a = CGFloat(hexNumber & 0x000000FF) / 255.0
            case 6:
                r = CGFloat((hexNumber & 0xFF0000) >> 16) / 255.0
                g = CGFloat((hexNumber & 0x00FF00) >> 8) / 255.0
                b = CGFloat(hexNumber & 0x0000FF) / 255.0
            default: break
            }
        } else {
            switch gaxbString {
                case "red": r = 1.0
                case "green": g = 1.0
                case "blue": b = 1.0
                default: break
            }
        }
        self.init(red: r, green:g, blue:b, alpha:a)
    }

    public func setWithGaxbString(GaxbString: String) {
        // immutable
    }
    
    public func toGaxbString() -> String {
        return ""
    }
}

