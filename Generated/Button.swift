//
// Autogenerated by gaxb at 11:23:55 PM on 01/11/15
//

public class Button: ButtonBase {
    public var button = UIButton()
    
    override public var view: UIView {
        get {
            return button
        }
        set {
            if newValue is UIButton {
                button = newValue as UIButton
            }
        }
    }
    
    public override func gaxbInit() {
        super.gaxbInit()
        button.setTitle("Normal", forState: .Normal)
        button.setTitle("Highlighted", forState: .Highlighted)
        button.setTitle("Selected", forState: .Selected)
        button.setTitle("Selected-Highlighted", forState: .Selected | .Highlighted)
        button.tintColor = UIColor.redColor()
        if onTouchUp != nil {
            button.addTarget(self, action: Selector("buttonOnTouchUp:"), forControlEvents: .TouchUpInside)
        }
        if onTouchDown != nil {
            button.addTarget(self, action: Selector("buttonOnTouchDown:"), forControlEvents: .TouchDown)
        }
        if tintColor != nil {
            button.tintColor = tintColor!
        }
    }
    
    @objc func buttonOnTouchUp(sender:UIButton!)
    {
        if onTouchUp != nil {
            let (scopeObject: GaxbElement?, name) = self.parseNotification(onTouchUp)
            if name != nil {
                NSNotificationCenter.defaultCenter().postNotificationName(name!, object: scopeObject as? AnyObject?)  // todo scope
            }
        }
        
        if isSelectable {
            sender.selected = !sender.selected;
        }
    }
    
    @objc func buttonOnTouchDown(sender:UIButton!)
    {
        if onTouchDown != nil {
            let (scopeObject: GaxbElement?, name) = self.parseNotification(onTouchDown)
            if name != nil {
                NSNotificationCenter.defaultCenter().postNotificationName(name!, object: scopeObject as AnyObject?)  // todo scope
            }
        }
    }
}
