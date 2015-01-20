//
// Autogenerated by gaxb at 01:38:55 PM on 01/20/15
//

public class TextField: TextFieldBase {
    var textField = UITextField()
    var textFieldWrapper = TextFieldWrapper()
    
    override public var view: UIView {
        get {
            textField.delegate = textFieldWrapper
            return textField
        }
        set {
            if newValue is UITextField {
                textField = newValue as UITextField
            }
        }
    }
    
    public override func gaxbPrepare() {
        super.gaxbPrepare()
        
        textFieldWrapper.textDelegate = self
        
        if text != nil {
            textField.text = text!
        }
        if placeholder != nil {
            textField.placeholder = placeholder!
        }
        if fontName != nil {
            textField.font = UIFont(name: fontName!, size: CGFloat(fontSize))
        }
        if textColor != nil {
            textField.textColor = textColor!
        }
        if textAlignment != nil {
            switch textAlignment! {
            case PlanetUI.textAlignment.Center:
                textField.textAlignment = .Center
            case PlanetUI.textAlignment.Right:
                textField.textAlignment = .Right
            case PlanetUI.textAlignment.Left:
                textField.textAlignment = .Left
            case PlanetUI.textAlignment.Justified:
                textField.textAlignment = .Justified
            case PlanetUI.textAlignment.Natural:
                textField.textAlignment = .Natural
            }
        }
        if adjustsFontSizeToFitWidth != nil {
            textField.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth!
        }
        if borderStyle != nil {
            switch borderStyle! {
            case PlanetUI.textFieldBorderStyle.line:
                textField.borderStyle = .Line
            case PlanetUI.textFieldBorderStyle.bezel:
                textField.borderStyle = .Bezel
            case PlanetUI.textFieldBorderStyle.roundedRect:
                textField.borderStyle = .RoundedRect
            default:
                textField.borderStyle = .None
            }
        }
        
        textField.minimumFontSize = CGFloat(minimumFontSize)
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if onBeginEditing != nil {
            doNotification(onBeginEditing!)
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if onEndEditing != nil {
            doNotification(onEndEditing!)
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) {
        if onReturnPressed != nil {
            doNotification(onReturnPressed!)
        }
    }
    
    func doNotification(note: String) {
        let (scopeObject: AnyObject?, name) = self.parseNotification(note)
        if name != nil {
            NSNotificationCenter.defaultCenter().postNotificationName(name!, object: scopeObject)
        }
    }
}

class TextFieldWrapper: NSObject, UITextFieldDelegate {
    var textDelegate: TextField?
    
    func textFieldDidBeginEditing(textField: UITextField) {
        var test = 0
        
        if textDelegate != nil {
            textDelegate!.textFieldDidBeginEditing(textField)
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        var test = 0
        
        if textDelegate != nil {
            textDelegate!.textFieldDidEndEditing(textField)
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) {
        var test = 0
        
        if textDelegate != nil {
            textDelegate!.textFieldShouldReturn(textField)
        }
    }
}