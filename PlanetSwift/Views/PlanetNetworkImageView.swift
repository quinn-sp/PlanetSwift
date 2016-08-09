//
//  PlanetNetworkImageView.swift
//  PlanetSwift
//
//  Created by Brad Bambara on 1/20/15.
//  Copyright (c) 2015 Small Planet. All rights reserved.
//

import UIKit

public class PlanetNetworkImageView: UIImageView {

	public var placeholderContentMode:UIViewContentMode = .ScaleToFill
	public var downloadedContentMode:UIViewContentMode = .ScaleToFill
    
    public func setImageWithPath(path: String?, placeholder:UIImage? = nil, completion:((success:Bool)->Void)? = nil) {
        guard let urlPath = path, url = NSURL(string: urlPath) else {
            setImage(nil, placeholder: placeholder, completion: completion)
            return
        }
        
        setImage(url, placeholder: placeholder, completion: completion)
    }
	
    public func setImage(url:NSURL?, placeholder:UIImage? = nil, completion:((success:Bool)->Void)? = nil) {
		
		self.contentMode = placeholderContentMode
		self.image = placeholder
        
        guard let imageUrl = url else {
            completion?(success: false)
            return
        }
        
		ImageCache.sharedInstance.get(imageUrl) { [weak self] (image:UIImage?) in
			
			if image != nil {
				if let downloadedContentMode = self?.downloadedContentMode {
					self?.contentMode = downloadedContentMode
				}
				self?.image = image
                completion?(success: true)
			}
            else {
                completion?(success: false)
            }
		}
	}
	
}
