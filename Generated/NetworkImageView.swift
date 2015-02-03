//
// Autogenerated by gaxb at 02:43:47 PM on 01/20/15
//

public class NetworkImageView: NetworkImageViewBase {
    
	lazy public var networkImageView = PlanetNetworkImageView()
	override public var imageView : UIImageView {
		get {
			return networkImageView
		}
		set {
			if newValue is PlanetNetworkImageView {
				networkImageView = newValue as PlanetNetworkImageView
			}
		}
	}
	
	public override func setImageWithPath(path:String) {
		
		if let url = NSURL(string: path) {
			
			var placeholder:UIImage?
			if placeholderPath != nil {
				placeholder = UIImage(named: String(bundlePath: placeholderPath!))
			}
			networkImageView.setImage(url, placeholder: placeholder)
		}
		else {
			super.setImageWithPath(path)
		}
	}
    
    override public init() {
        super.init()
    }
	
	/*
	public func setImageWithBundlePath(bundlePath:String) {
	if let img: UIImage = UIImage(named: String(bundlePath: bundlePath)) {
	imageView.image = img
	}
	}
*/
	
}
