//
// Autogenerated by gaxb at 03:15:42 PM on 01/14/15
//

public class Image: ImageBase {
    public var imageView = UIImageView();
    
    override public var view: UIView {
        get {
            return imageView
        }
        set {
            if newValue is UIImageView {
                imageView = newValue as UIImageView
            }
        }
    }
    
    override func gaxbValueDidChange(name: String) {
        super.gaxbValueDidChange(name)
        switch name {
        case "urlPath":
            let img: UIImage? = UIImage(named: String(bundlePath: urlPath!))
            imageView.image = img
            break
        default:
            break
        }
    }
}
