//
//  PlanetButton.swift
//  PlanetSwift
//
//  Created by Nicholas Bowlin on 1/21/15.
//  Copyright (c) 2015 Small Planet. All rights reserved.
//

import UIKit

public class PlanetButton: UIButton {
    
    override init() {
        super.init()
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(bgColor: UIColor, bgColorHighlighted: UIColor, bgColorSelected: UIColor, bgColorSelectedHighlighted: UIColor, bgColorDisabled: UIColor, toggle: Bool)
    {
        self.init();
        
        backgroundColorNormal = bgColor
        backgroundColorHighlighted = bgColorHighlighted
        backgroundColorSelected = bgColorSelected
        backgroundColorSelectedHighlighted = bgColorSelectedHighlighted
        isToggle = toggle
		self.addTarget(self, action: Selector("touchUpInside:"), forControlEvents: .TouchUpInside)
    }
	
    var isToggle: Bool = false
    
    var backgroundColorNormal: UIColor? {
        didSet {
            backgroundColor = backgroundColorNormal
        }
    }
    
    var backgroundColorHighlighted: UIColor?
    var _backgroundColorHighlighted: UIColor? {
        return backgroundColorHighlighted != nil ? backgroundColorHighlighted : backgroundColorNormal
    }
    
    var backgroundColorSelected: UIColor?
    var _backgroundColorSelected: UIColor? {
        return backgroundColorSelected != nil ? backgroundColorSelected : _backgroundColorHighlighted
    }
    
    var backgroundColorSelectedHighlighted: UIColor?
    var _backgroundColorSelectedHighlighted: UIColor? {
        return backgroundColorSelectedHighlighted != nil ? backgroundColorSelectedHighlighted : _backgroundColorHighlighted
    }
    
    var backgroundColorDisabled: UIColor?
    var _backgroundColorDisabled: UIColor? {
        return backgroundColorDisabled != nil ? backgroundColorDisabled : backgroundColorNormal
    }
	
	private func updateBackgroundColor() {
		
		if enabled == false {
			backgroundColor = _backgroundColorDisabled
		}
		else {
			switch (highlighted, selected) {
			case (true, false):
				checkBackgroundColor(_backgroundColorHighlighted)
			case (true, true):
				checkBackgroundColor(_backgroundColorSelectedHighlighted)
			case (false, true):
				checkBackgroundColor(_backgroundColorSelected)
			default:
				checkBackgroundColor(backgroundColorNormal)
			}
		}
	}
	
    public override var enabled: Bool {
        didSet {
			updateBackgroundColor()
        }
    }
    
    public override var highlighted: Bool {
        didSet {
            updateBackgroundColor()
        }
    }
	
	public override var selected: Bool {
		didSet {
			updateBackgroundColor()
		}
	}
	
    func checkBackgroundColor(color: UIColor?)
    {
        if color != nil {
            backgroundColor = color!
        }
    }
    
    func touchUpInside(sender: UIButton!) {
		if isToggle {
			selected = !selected
		}
    }
}