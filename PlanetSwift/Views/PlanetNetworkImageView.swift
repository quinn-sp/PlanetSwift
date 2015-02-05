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
	
	public func setImage(url:NSURL, placeholder:UIImage? = nil) {
		
		self.contentMode = placeholderContentMode
		self.image = placeholder
		
		ImageCache.sharedInstance.get(url) { [unowned self] (image:UIImage?) in
			
			if image != nil {
				self.contentMode = self.downloadedContentMode
				self.image = image
			}
		}
	}
	
}
