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
    convenience init?(gaxbString: String?) {
        guard let gaxbString = gaxbString else { return nil }
        if gaxbString.rangeOfString(":/") != nil {
            self.init(contentsOfFile:(String(bundlePath: gaxbString)))
        } else {
            self.init(named: gaxbString)
        }
    }
    
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
    public convenience init(gaxbString: String) {
        var (r,g,b,a): (CGFloat, CGFloat, CGFloat, CGFloat) = (0.0, 0.0, 0.0, 1.0)
        if gaxbString.hasPrefix("#") {
            let substring = gaxbString.substringFromIndex(gaxbString.startIndex.advancedBy(1))
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
        return self.init(withPlanetTextAlignment: alignment)
	}
    public init(withPlanetTextAlignment alignment: PlanetUI.TextAlignment) {
        switch alignment {
        case .center:
            self = NSTextAlignment.Center
        case .right:
            self = NSTextAlignment.Right
        case .left:
            self = NSTextAlignment.Left
        case .justified:
            self = NSTextAlignment.Justified
        case .natural:
            self = NSTextAlignment.Natural
        }
    }
}

extension NSLineBreakMode {
	public static func fromPlanetUILineBreakMode(mode:PlanetUI.LineBreakMode) -> NSLineBreakMode {
        return self.init(withPlanetLineBreakMode: mode)
    }
    public init(withPlanetLineBreakMode mode: PlanetUI.LineBreakMode) {
		switch mode {
		case .truncatingTail:
			self = .ByTruncatingTail
		case .wordWrapping:
			self = .ByWordWrapping
		case .charWrapping:
			self = .ByCharWrapping
		case .truncatingHead:
			self = .ByTruncatingHead
		case .clipping:
			self = .ByClipping
		case .truncatingMiddle:
			self = .ByTruncatingMiddle
		}
	}
}

extension UIDatePickerMode {
    public static func fromPlanetUIDatePickerMode(mode:PlanetUI.DatePickerMode) -> UIDatePickerMode {
        return self.init(withPlanetDatePickerMode: mode)
    }
    public init(withPlanetDatePickerMode mode: PlanetUI.DatePickerMode) {
        switch mode {
        case .time:
            self = UIDatePickerMode.Time
        case .date:
            self = UIDatePickerMode.Date
        case .dateAndTime:
            self = UIDatePickerMode.DateAndTime
        case .countDownTimer:
            self = UIDatePickerMode.CountDownTimer
        }
    }
}

extension UITextBorderStyle {
	public static func fromPlanetUITextFieldBorderStyle(style:PlanetUI.TextBorderStyle) -> UITextBorderStyle {
        return self.init(withPlanetTextBorderStyle: style)
    }
    public init(withPlanetTextBorderStyle style: PlanetUI.TextBorderStyle) {
		switch style {
		case .line:
			self = .Line
		case .bezel:
			self = .Bezel
		case .roundedRect:
			self = .RoundedRect
		default:
			self = .None
		}
	}
}

extension UITextFieldViewMode {
	public static func fromPlanetUITextFieldViewMode(mode:PlanetUI.TextFieldViewMode) -> UITextFieldViewMode {
        return self.init(withPlanetTextFieldViewMode: mode)
    }
    public init(withPlanetTextFieldViewMode mode: PlanetUI.TextFieldViewMode) {
		switch mode {
		case .always:
			self = .Always
		case .never:
			self = .Never
		case .unlessEditing:
			self = .UnlessEditing
		case .whileEditing:
			self = .WhileEditing
		}
	}
}

extension UIViewContentMode {
	public static func fromPlanetUIContentMode(mode:PlanetUI.ContentMode) -> UIViewContentMode {
        return self.init(withPlanetContentMode: mode)
    }
    public init(withPlanetContentMode mode: PlanetUI.ContentMode) {
		switch mode {
		case .scaleToFill:
			self = .ScaleToFill
		case .scaleAspectFit:
			self = .ScaleAspectFit
		case .scaleAspectFill:
			self = .ScaleAspectFill
		case .redraw:
			self = .Redraw
		case .center:
			self = .Center
		case .top:
			self = .Top
		case .bottom:
			self = .Bottom
		case .left:
			self = .Left
		case .right:
			self = .Right
		case .topLeft:
			self = .TopLeft
		case .topRight:
			self = .TopRight
		case .bottomLeft:
			self = .BottomLeft
		case .bottomRight:
			self = .BottomRight
		}
	}
}

extension UIReturnKeyType {
	public static func fromPlanetUIReturnKeyType(type:PlanetUI.ReturnKeyType) -> UIReturnKeyType {
        return self.init(withPlanetReturnKeyType: type)
    }
    public init(withPlanetReturnKeyType type: PlanetUI.ReturnKeyType) {
		switch type {
		case .Default:
			self = .Default
		case .go:
			self = .Go
		case .google:
			self = .Google
		case .join:
			self = .Join
		case .next:
			self = .Next
		case .route:
			self = .Route
		case .search:
			self = .Search
		case .send:
			self = .Send
		case .yahoo:
			self = .Yahoo
		case .done:
			self = .Done
		case .emergencyCall:
			self = .EmergencyCall
		}
	}
}

extension UIKeyboardType {
	public static func fromPlanetUIKeyboardType(type:PlanetUI.KeyboardType) -> UIKeyboardType {
        return self.init(withPlanetKeyboardType: type)
    }
    public init(withPlanetKeyboardType type: PlanetUI.KeyboardType) {
		switch type {
		case .Default:
			self = .Default
		case .ASCIICapable:
			self = .ASCIICapable
		case .numbersAndPunctuation:
			self = .NumbersAndPunctuation
		case .URL:
			self = .URL
		case .numberPad:
			self = .NumberPad
		case .phonePad:
			self = .PhonePad
		case .namePhonePad:
			self = .NamePhonePad
		case .emailAddress:
			self = .EmailAddress
		case .decimalPad:
			self = .DecimalPad
		case .twitter:
			self = .Twitter
		case .webSearch:
			self = .WebSearch
		}
	}
}

extension UIActivityIndicatorViewStyle {
    public static func fromPlanetUIActivityIndicatorViewStyle(type:PlanetUI.ActivityIndicatorViewStyle) -> UIActivityIndicatorViewStyle {
        return self.init(withPlanetActivityIndicatorViewStyle: type)
    }
    public init(withPlanetActivityIndicatorViewStyle style: PlanetUI.ActivityIndicatorViewStyle) {
		switch style {
		case .whiteLarge:
			self = .WhiteLarge
		case .white:
			self = .White
		case .gray:
			self = .Gray
		}
	}
}

extension UITextAutocapitalizationType {
	public static func fromPlanetUITextAutocapitalizationType(type:PlanetUI.TextAutocapitalizationType) -> UITextAutocapitalizationType {
        return self.init(withPlanetTextAutocapitalizationType: type)
    }
    public init(withPlanetTextAutocapitalizationType type: PlanetUI.TextAutocapitalizationType) {
		switch type {
		case .none:
			self = .None
		case .words:
			self = .Words
		case .sentences:
			self = .Sentences
		case .allCharacters:
			self = .AllCharacters
		}
	}
}

extension UITextAutocorrectionType {
	public static func fromPlanetUITextAutocorrectionType(type:PlanetUI.TextAutocorrectionType) -> UITextAutocorrectionType {
        return self.init(withPlanetTextAutocorrectionType: type)
    }
    public init(withPlanetTextAutocorrectionType type: PlanetUI.TextAutocorrectionType) {
		switch type {
		case .Default:
			self = .Default
		case .no:
			self = .No
		case .yes:
			self = .Yes
		}
	}
}

extension UITextSpellCheckingType {
	public static func fromPlanetUITextSpellCheckingType(type:PlanetUI.TextSpellCheckingType) -> UITextSpellCheckingType {
        return self.init(withPlanetTextSpellCheckingType: type)
    }
    public init(withPlanetTextSpellCheckingType type: PlanetUI.TextSpellCheckingType) {
		switch type {
		case .Default:
			self = .Default
		case .no:
			self = .No
		case .yes:
			self = .Yes
		}
	}
}
