//
//  ImageCache.swift
//  PlanetSwift
//
//  Created by Brad Bambara on 1/20/15.
//  Copyright (c) 2015 Small Planet. All rights reserved.
//

import UIKit

private let ImageCache_shared = ImageCache()

public typealias ImageCache_CompletionBlock = ((UIImage?) -> Void)
typealias ImageCache_DownloadBlock = ((_ success:Bool) -> Void)

public class ImageCache {
	
	//MARK: - public API
	
	public class var sharedInstance: ImageCache {
		return ImageCache_shared
	}
	
	public func get(_ url:URL, completion:@escaping ImageCache_CompletionBlock) {
        let imageKey = url.absoluteString
			
        if let memCacheImage = memoryCache.object(forKey: imageKey as NSString) as? UIImage {
            completion(memCacheImage)
            return
        }
            
        if url.isFileURL {
            if let image = UIImage(contentsOfFile: imageKey) {
                
                memoryCache.setObject(image, forKey: imageKey as NSString)
                completion(image)
                
                return
            }
        }
        
        var cacheRequest:ImageCacheRequest!
        if let activeRequest = activeRequestForKey(imageKey) {
            cacheRequest = activeRequest
        }
        else {
            cacheRequest = ImageCacheRequest(url: url, completion: { [weak self] (success:Bool) in
                
                if self != nil {
                    var image:UIImage? = nil
                    if success {
                        image = UIImage(data: cacheRequest.imageData as Data)
                        if image != nil {
                            self!.memoryCache.setObject(image!, forKey: imageKey as NSString)
                        }
                    }
                    
                    var index = 0
                    for request in self!.activeNetworkRequests {
                        
                        if request === cacheRequest {
                            break
                        }
                        index += 1
                    }
                    self!.activeNetworkRequests.remove(at: index)
                    
                    //call all completion blocks
                    for block in cacheRequest.completionBlocks {
                        block(image)
                    }
                }
            })
            activeNetworkRequests.append(cacheRequest)
        }
        
        //append our completion block to this already-in-progress request
        cacheRequest.completionBlocks.append(completion)
	}
	
	public func get(_ key:AnyObject) -> UIImage? {
		return memoryCache.object(forKey: key) as? UIImage
	}
	
	public func set(_ image:UIImage, key:AnyObject) {
		memoryCache.setObject(image, forKey: key)
	}
	
	//MARK: - private
	
	private let memoryCache = NSCache<AnyObject, AnyObject>()
	private var activeNetworkRequests = Array<ImageCacheRequest>()
	
	private func activeRequestForKey(_ key:String) -> ImageCacheRequest? {
		for request in activeNetworkRequests {
			if request.request.url!.absoluteString == key {
				return request
			}
		}
		return nil
	}
}

internal class ImageCacheRequest : NSObject, NSURLConnectionDelegate, NSURLConnectionDataDelegate {
	
	var completionBlocks = Array<ImageCache_CompletionBlock>()
	let request:URLRequest
	var connection:NSURLConnection?
	let completionBlock:ImageCache_DownloadBlock
	let imageData:NSMutableData
	
	init(url:URL, completion:@escaping ImageCache_DownloadBlock) {
		
		completionBlock = completion
		request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 60)
		imageData = NSMutableData()
		connection = NSURLConnection()
        
		super.init()
		
		connection = NSURLConnection(request: request, delegate: self, startImmediately: false)
        connection?.schedule(in: RunLoop.current, forMode: RunLoopMode.commonModes)
        connection?.start()
		if connection == nil {
			completionBlock(false)
		}
	}
	
	//MARK: - NSURLConnectionDelegate
	
	private func connection(_ connection: NSURLConnection, didFailWithError error: NSError) {
		completionBlock(false)
	}
	
	//MARK: - NSURLConnectionDataDelegate
	
	func connection(_ connection: NSURLConnection, didReceive data: Data) {
		imageData.append(data)
	}
	
	func connectionDidFinishLoading(_ connection: NSURLConnection) {
		completionBlock(true)
	}
	
}
