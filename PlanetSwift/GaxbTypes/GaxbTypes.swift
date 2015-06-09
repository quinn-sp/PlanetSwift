//
//  GaxbTypes.swift
//  Copyright (c) 2014 Small Planet. All rights reserved.
//

import UIKit

// MARK: - XSD datatypes

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

extension Int: GaxbType {
    public init(gaxbString: String) {
        self.init()
        self.setWithGaxbString(gaxbString)
    }
    public mutating func setWithGaxbString(gaxbString: String) {
        if let tmp = Int(gaxbString) as Int? {
            self = tmp
        } else {
            self = 0
        }
    }
    public func toGaxbString() -> String {
        return String(self)
    }
}

extension Float: GaxbType {
    public init(gaxbString: String) {
        self.init()
        self.setWithGaxbString(gaxbString)
    }
    public mutating func setWithGaxbString(gaxbString: String) {
        self = (gaxbString as NSString).floatValue
    }
    public func toGaxbString() -> String {
        return String(format: "%.5f", self)
    }
}

extension Double: GaxbType {
    public init(gaxbString: String) {
        self.init()
        self.setWithGaxbString(gaxbString)
    }
    public mutating func setWithGaxbString(gaxbString: String) {
        self = (gaxbString as NSString).doubleValue
    }
    public func toGaxbString() -> String {
        return String(format: "%.5f", self)
    }
}

// MARK: - GAXB-defined types

extension CGRect: GaxbType {
    public init(gaxbString withGaxbString: String) {
        let (origin, size) = CGRect.componentsFromString(withGaxbString)
        self.init(origin: origin, size: size)
    }
    public mutating func setWithGaxbString(GaxbString: String) {
        let (newOrigin, newSize) = CGRect.componentsFromString(GaxbString)
        origin = newOrigin
        size = newSize
    }
    public static func componentsFromString(string: String) -> (CGPoint, CGSize) {
        var x:Float=0.0, y:Float=0.0, w:Float=0.0, h:Float=0.0
        var components = string.componentsSeparatedByString(",")
        if components.count == 4 {
            x = (components[0] as NSString).floatValue
            y = (components[1] as NSString).floatValue
            w = (components[2] as NSString).floatValue
            h = (components[3] as NSString).floatValue
        }
        let origin = CGPoint(x: CGFloat(x), y: CGFloat(y))
        let size = CGSize(width: CGFloat(w), height: CGFloat(h))
        return (origin, size)
    }
    public func toGaxbString() -> String {
        return "\(origin.x),\(origin.y),\(size.width),\(size.height)"
    }
}

extension UIEdgeInsets: GaxbType {
    public init(gaxbString withGaxbString: String) {
        let (top, left, bottom, right) = UIEdgeInsets.componentsFromString(withGaxbString)
        self = UIEdgeInsetsMake(top, left, bottom, right)
    }
    public mutating func setWithGaxbString(GaxbString: String) {
        (top, left, bottom, right) = UIEdgeInsets.componentsFromString(GaxbString)
    }
    public static func componentsFromString(string: String) -> (CGFloat, CGFloat, CGFloat, CGFloat) {
        var t:Float=0.0, l:Float=0.0, b:Float=0.0, r:Float=0.0
        var components = string.componentsSeparatedByString(",")
        if components.count == 4 {
            t = (components[0] as NSString).floatValue
            l = (components[1] as NSString).floatValue
            b = (components[2] as NSString).floatValue
            r = (components[3] as NSString).floatValue
        }
        return (CGFloat(t), CGFloat(l), CGFloat(b), CGFloat(r))
    }
    public func toGaxbString() -> String {
        return "\(top),\(left),\(bottom),\(right))"
    }
}

extension CGSize: GaxbType {
	public init(gaxbString: String) {
		let (width, height) = CGSize.componentsFromString(gaxbString)
        self.init(width: width, height: height)
	}
	mutating public func setWithGaxbString(GaxbString: String) {
		let (newWidth, newHeight) = CGPoint.componentsFromString(GaxbString)
		width = newWidth
		height = newHeight
	}
	public static func componentsFromString(string: String) -> (CGFloat, CGFloat) {
		var width:Float=0.0, height:Float=0.0
		var components = string.componentsSeparatedByString(",")
		if components.count == 2 {
			width = (components[0] as NSString).floatValue
			height = (components[1] as NSString).floatValue
		}
		return (CGFloat(width), CGFloat(height))
	}
	public func toGaxbString() -> String {
		return "\(width),\(height)"
	}
}

extension CGPoint: GaxbType {
    public init(gaxbString: String) {
        let (x, y) = CGPoint.componentsFromString(gaxbString)
        self.init(x: x, y: y)
    }
    mutating public func setWithGaxbString(GaxbString: String) {
        let (newX, newY) = CGPoint.componentsFromString(GaxbString)
        x = newX
        y = newY
    }
    public static func componentsFromString(string: String) -> (CGFloat, CGFloat) {
        var x:Float=0.0, y:Float=0.0
        var components = string.componentsSeparatedByString(",")
        if components.count == 2 {
            x = (components[0] as NSString).floatValue
            y = (components[1] as NSString).floatValue
        }
        return (CGFloat(x), CGFloat(y))
    }
    public func toGaxbString() -> String {
        return "\(x),\(y)"
    }
}

// MARK: - UIKit data types

extension UIImage {
    convenience init?(validateAndLoad name: String!) {
        self.init(named: name)
        
        // need to assert here if self.init fails
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
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
            let _ = NSScanner(string: substring).scanHexInt(&hexNumber)
            switch substring.characters.count {
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
            case "white": r = 1.0; g = 1.0; b = 1.0
            default: break
            }
        }
        self.init(red: r, green:g, blue:b, alpha:a)
    }
    public func setWithGaxbString(GaxbString: String) {
        // immutable
    }
    public func toGaxbString() -> String {
        var r:CGFloat = 0, g:CGFloat = 0, b:CGFloat = 0, a:CGFloat = 0
        if self.getRed(&r, green:&g , blue: &b, alpha: &a) {
            let hexNumber = Int(r*255) << 24 + Int(g*255) << 16 + Int(b*255) << 8 + Int(a*255)
            return NSString(format:"#%08X", hexNumber) as String
        }
        return ""
    }
    public func getRGBA() -> (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        var (r,g,b,a): (CGFloat, CGFloat, CGFloat, CGFloat) = (-1.0, -1.0, -1.0,-1.0)
        self.getRed(&r, green:&g , blue: &b, alpha: &a)
        return (r, g, b, a)
    }
}

//MARK: - enum conversion

extension NSTextAlignment {
	public static func fromPlanetUITextAlignment(alignment:PlanetUI.TextAlignment) -> NSTextAlignment {
		switch alignment {
		case .center:
			return NSTextAlignment.Center
		case .right:
			return NSTextAlignment.Right
		case .left:
			return NSTextAlignment.Left
		case .justified:
			return NSTextAlignment.Justified
		case .natural:
			return NSTextAlignment.Natural
		}
	}
}

extension NSLineBreakMode {
	public static func fromPlanetUILineBreakMode(mode:PlanetUI.LineBreakMode) -> NSLineBreakMode {
		switch mode {
		case .truncatingTail:
			return .ByTruncatingTail
		case .wordWrapping:
			return .ByWordWrapping
		case .charWrapping:
			return .ByCharWrapping
		case .truncatingHead:
			return .ByTruncatingHead
		case .clipping:
			return .ByClipping
		case .truncatingMiddle:
			return .ByTruncatingMiddle
		}
	}
}

extension UITextBorderStyle {
	public static func fromPlanetUITextFieldBorderStyle(style:PlanetUI.TextBorderStyle) -> UITextBorderStyle {
		switch style {
		case .line:
			return .Line
		case .bezel:
			return .Bezel
		case .roundedRect:
			return .RoundedRect
		default:
			return .None
		}
	}
}

extension UITextFieldViewMode {
	public static func fromPlanetUITextFieldViewMode(mode:PlanetUI.TextFieldViewMode) -> UITextFieldViewMode {
		switch mode {
		case .always:
			return .Always
		case .never:
			return .Never
		case .unlessEditing:
			return .UnlessEditing
		case .whileEditing:
			return .WhileEditing
		}
	}
}

extension UIViewContentMode {
	public static func fromPlanetUIContentMode(mode:PlanetUI.ContentMode) -> UIViewContentMode {
		switch mode {
		case .scaleToFill:
			return .ScaleToFill
		case .scaleAspectFit:
			return .ScaleAspectFit
		case .scaleAspectFill:
			return .ScaleAspectFill
		case .redraw:
			return .Redraw
		case .center:
			return .Center
		case .top:
			return .Top
		case .bottom:
			return .Bottom
		case .left:
			return .Left
		case .right:
			return .Right
		case .topLeft:
			return .TopLeft
		case .topRight:
			return .TopRight
		case .bottomLeft:
			return .BottomLeft
		case .bottomRight:
			return .BottomRight
		}
	}
}

extension UIReturnKeyType {
	public static func fromPlanetUIReturnKeyType(type:PlanetUI.ReturnKeyType) -> UIReturnKeyType {
		switch type {
		case .Default:
			return .Default
		case .go:
			return .Go
		case .google:
			return .Google
		case .join:
			return .Join
		case .next:
			return .Next
		case .route:
			return .Route
		case .search:
			return .Search
		case .send:
			return .Send
		case .yahoo:
			return .Yahoo
		case .done:
			return .Done
		case .emergencyCall:
			return .EmergencyCall
		}
	}
}

extension UIKeyboardType {
	public static func fromPlanetUIKeyboardType(type:PlanetUI.KeyboardType) -> UIKeyboardType {
		switch type {
		case .Default:
			return .Default
		case .ASCIICapable:
			return .ASCIICapable
		case .numbersAndPunctuation:
			return .NumbersAndPunctuation
		case .URL:
			return .URL
		case .numberPad:
			return .NumberPad
		case .phonePad:
			return .PhonePad
		case .namePhonePad:
			return .NamePhonePad
		case .emailAddress:
			return .EmailAddress
		case .decimalPad:
			return .DecimalPad
		case .twitter:
			return .Twitter
		case .webSearch:
			return .WebSearch
		}
	}
}

extension UIActivityIndicatorViewStyle {
    public static func fromPlanetUIActivityIndicatorViewStyle(type:PlanetUI.ActivityIndicatorViewStyle) -> UIActivityIndicatorViewStyle {
		switch type {
		case .whiteLarge:
			return .WhiteLarge
		case .white:
			return .White
		case .gray:
			return .Gray
		}
	}
}

extension UITextAutocapitalizationType {
	public static func fromPlanetUITextAutocapitalizationType(type:PlanetUI.TextAutocapitalizationType) -> UITextAutocapitalizationType {
		switch type {
		case .none:
			return .None
		case .words:
			return .Words
		case .sentences:
			return .Sentences
		case .allCharacters:
			return .AllCharacters
		}
	}
}

extension UITextAutocorrectionType {
	public static func fromPlanetUITextAutocorrectionType(type:PlanetUI.TextAutocorrectionType) -> UITextAutocorrectionType {
		switch type {
		case .Default:
			return .Default
		case .no:
			return .No
		case .yes:
			return .Yes
		}
	}
}

extension UITextSpellCheckingType {
	public static func fromPlanetUITextSpellCheckingType(type:PlanetUI.TextSpellCheckingType) -> UITextSpellCheckingType {
		switch type {
		case .Default:
			return .Default
		case .no:
			return .No
		case .yes:
			return .Yes
		}
	}
}
