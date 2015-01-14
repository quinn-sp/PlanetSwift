//
// Autogenerated by gaxb at 10:39:28 AM on 12/12/14
//

import UIKit

public class View: ViewBase {
    public var view = UIView()
    
    override func gaxbValueDidChange(name: String) {
        super.gaxbValueDidChange(name)

        switch name {
        case "frame":
            view.frame = frame!
        case "color":
            view.backgroundColor = color
        case "alpha":
            view.alpha = CGFloat(alpha!)
        case "clipsToBounds":
            if clipsToBounds != nil {
                view.clipsToBounds = clipsToBounds!
            }
        case "hidden":
            if hidden != nil {
                view.hidden = hidden!
            }
        case "tag":
            if tag != nil {
                view.tag = tag!
            }
        default:
            break
        }
    }
	
	internal func findParentView() -> View? {
		var parent:GaxbElement? = self.parent
		while parent != nil {
			
			if let view = parent as? View {
				return view
			}
			
			parent = parent!.parent
		}
		return nil
	}
	
	public override func load(context: AnyObject?) {
		findParentView()?.view.addSubview(view)
	}
	
}
