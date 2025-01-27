//
// Autogenerated by gaxb at 02:43:47 PM on 01/20/15
//

import UIKit

public class NetworkImageView: NetworkImageViewBase {
    
    lazy public var networkImageView: PlanetNetworkImageView = PlanetNetworkImageView()
	override public var imageView : UIImageView {
		get {
			return networkImageView
		}
		set {
			if let newValue = newValue as? PlanetNetworkImageView {
				networkImageView = newValue
			}
		}
	}
    
    public func setImageWithPath(_ path:String?, completion:((_ success:Bool)->Void)?) {
        if let path = path, let url = URL(string: path) {
            var placeholder: UIImage?
            if let placeholderPath = placeholderPath {
                placeholder = UIImage(gaxbString: placeholderPath)
            }
            networkImageView.setImage(url, placeholder: placeholder, completion: completion)
        } else {
            super.setImageWithString(path)
            completion?(false)
        }
    }
	
    public override func setImageWithString(_ image: String?) {
		setImageWithPath(image, completion: nil)
	}
	
	public override func gaxbPrepare() {
		super.gaxbPrepare()
		
        if let placeholderPath = placeholderPath {
            networkImageView.image = UIImage(contentsOfFile: String(bundlePath: placeholderPath))
        }
        
		if let placeholderContentMode = placeholderContentMode {
			networkImageView.placeholderContentMode = UIViewContentMode.fromPlanetUIContentMode(placeholderContentMode)
		}
		if let contentMode = contentMode {
			networkImageView.downloadedContentMode = UIViewContentMode.fromPlanetUIContentMode(contentMode)
		}
	}
}
