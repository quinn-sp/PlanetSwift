//
//  PlanetNetworkImageView.swift
//  PlanetSwift
//
//  Created by Brad Bambara on 1/20/15.
//  Copyright (c) 2015 Small Planet. All rights reserved.
//

import UIKit

public class PlanetNetworkImageView: UIImageView {

	public var placeholderContentMode:UIViewContentMode = .scaleToFill
	public var downloadedContentMode:UIViewContentMode = .scaleToFill
	
    public func setImage(_ url:URL, placeholder:UIImage? = nil, completion:((_ success:Bool)->Void)? = nil) {
		
		self.contentMode = placeholderContentMode
		self.image = placeholder
		
		ImageCache.sharedInstance.get(url) { [weak self] (image:UIImage?) in
			
			if image != nil {
				if let downloadedContentMode = self?.downloadedContentMode {
					self?.contentMode = downloadedContentMode
				}
				self?.image = image
                completion?(true)
			}
            else {
                completion?(false)
            }
		}
	}
	
}
