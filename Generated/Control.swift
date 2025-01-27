//
// Autogenerated by gaxb at 11:46:44 AM on 02/24/15
//

import UIKit

public class Control: ControlBase {
	
	public var control:UIControl?
	override public var view: UIView {
		get {
			return control ?? super.view
		}
		set {
			if let newValue = newValue as? UIControl {
				control = newValue
			}
		}
	}
	
	public override func gaxbPrepare() {
		super.gaxbPrepare()
		
        guard let control = control else { return }
        
        if let enabled = enabled {
            control.isEnabled = enabled
        }
        if let selected = selected {
            control.isSelected = selected
        }
        if let highlighted = highlighted {
            control.isHighlighted = highlighted
        }
	}
}
