//
//  ImageCache.swift
//  PlanetSwift
//
//  Created by Brad Bambara on 1/20/15.
//  Copyright (c) 2015 Small Planet. All rights reserved.
//

private let ImageCache_shared = ImageCache()

public typealias ImageCache_CompletionBlock = (UIImage? -> Void)
typealias ImageCache_DownloadBlock = ((success:Bool) -> Void)

public class ImageCache {
	
	//MARK: - static shared instance
	
	class var sharedInstance: ImageCache {
		return ImageCache_shared
	}
	
	//MARK: - various caching mechanisms
	
	let memoryCache = NSCache()
	var activeNetworkRequests = Array<ImageCacheRequest>()
	
	public func get(url:NSURL, completion:ImageCache_CompletionBlock) {
		
		if let imageKey = url.absoluteString {
			
			if let memCacheImage = memoryCache.objectForKey(imageKey) as? UIImage {
				completion(memCacheImage)
				return
			}
				
			if url.isFileReferenceURL() {
				if let image = UIImage(contentsOfFile: imageKey) {
					
					memoryCache.setObject(image, forKey: imageKey)
					completion(image)
					
					return
				}
			}
			
			var cacheRequest:ImageCacheRequest!
			if let activeRequest = activeRequestForKey(imageKey) {
				cacheRequest = activeRequest
			}
			else {
				cacheRequest = ImageCacheRequest(url: url, completion: { [unowned self] (success:Bool) in
					
					var image:UIImage? = nil
					if success {
						image = UIImage(data: cacheRequest.imageData)
						if image != nil {
							self.memoryCache.setObject(image!, forKey: imageKey)
						}
					}
					
					//call all completion blocks
					for block in cacheRequest.completionBlocks {
						block(image)
					}
				})
			}
			
			//append our completion block to this already-in-progress request
			cacheRequest.completionBlocks.append(completion)
		}
		else {
			completion(nil)
		}
	}
	
	func activeRequestForKey(key:String) -> ImageCacheRequest? {
		for request in activeNetworkRequests {
			if request.request.URL.absoluteString == key {
				return request
			}
		}
		return nil
	}
}

internal class ImageCacheRequest : NSObject, NSURLConnectionDelegate, NSURLConnectionDataDelegate {
	
	var completionBlocks = Array<ImageCache_CompletionBlock>()
	let request:NSURLRequest
	let connection:NSURLConnection?
	let completionBlock:ImageCache_DownloadBlock
	let imageData:NSMutableData
	
	init(url:NSURL, completion:ImageCache_DownloadBlock) {
		
		completionBlock = completion
		request = NSURLRequest(URL: url, cachePolicy: .ReturnCacheDataElseLoad, timeoutInterval: 60)
		imageData = NSMutableData()
		
		super.init()
		
		connection = NSURLConnection(request: request, delegate: self)
		if connection == nil {
			completionBlock(success: false)
		}
	}
	
	//MARK: - NSURLConnectionDelegate
	
	func connection(connection: NSURLConnection, didFailWithError error: NSError) {
		completionBlock(success: false)
	}
	
	//MARK: - NSURLConnectionDataDelegate
	
	func connection(connection: NSURLConnection, didReceiveData data: NSData) {
		imageData.appendData(data)
	}
	
	func connectionDidFinishLoading(connection: NSURLConnection) {
		completionBlock(success: true)
	}
	
}
