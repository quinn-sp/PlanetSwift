//
// Autogenerated by gaxb at 06:41:41 PM on 12/27/14
//

import UIKit

private var config:NSDictionary?
private var attemptedConfigLoad = false

extension PlanetUI {
	
	//MARK: - config
	
    public class func configForKey(_ key: String?) -> AnyObject? {
        guard let key = key else { return nil }
        checkLoadConfig()
        return config?.value(forKeyPath: key)
    }
    
    public class func configStringForKey(_ key: String?) -> String? {
        return PlanetUI.configForKey(key) as? String
    }
    
    public class func configIntForKey(_ key: String?) -> Int? {
        return (PlanetUI.configForKey(key) as? NSNumber)?.intValue ?? (PlanetUI.configForKey(key) as? NSString)?.integerValue
    }
    
    public class func configFloatForKey(_ key: String?) -> Float? {
        return (PlanetUI.configForKey(key) as? NSString)?.floatValue ?? (PlanetUI.configForKey(key) as? NSNumber)?.floatValue
    }
    
    public class func configCGFloatForKey(_ key: String?) -> CGFloat? {
        guard let value = PlanetUI.configFloatForKey(key) else { return nil }
        return CGFloat(value)
    }
    
    public class func configColorForKey(_ key: String?) -> UIColor? {
        guard let colorString = PlanetUI.configStringForKey(key) else { return nil }
        return UIColor(gaxbString: colorString)
    }
    
    public class func configFont(forNameKey name: String, sizeKey size: String) -> UIFont? {
        guard let name = self.configStringForKey(name), let size = self.configCGFloatForKey(size) else { return nil }
        return UIFont(name: name, size: size)
    }
	
	public class func configImageForKey(_ key: String?) -> UIImage? {
        guard let bundlePath = PlanetUI.configStringForKey(key) else { return nil }
        return UIImage(gaxbString: bundlePath)
	}
	
	public class func configRemoteImageForKey(_ key: String, completion: ImageCache_CompletionBlock) {
        guard let urlString = PlanetUI.configStringForKey(key), let url = URL(string: urlString) else { return }
        ImageCache.sharedInstance.get(url, completion: completion)
	}
	
    private class func checkLoadConfig() {
        
        #if RELEASE
        println("")
        #endif

        if config == nil && !attemptedConfigLoad {
            attemptedConfigLoad = true
            if let path = PlanetSwiftConfiguration.valueForKey(PlanetSwiftConfiguration_configPathKey) as? String {
                config = NSDictionary(contentsOfFile: String(bundlePath: path))
            }
        }
    }
	
	//MARK: - processing expressions
	
    public class func processExpressions(_ string: String) -> String {
		let processedString = NSMutableString(string: string)
        checkLoadConfig()
		if config != nil {
			findAndReplaceExpressions(processedString, expressionName:"config", expressionEvaluatorBlock: configForKey)
		}
        return processedString as String
    }
	
	public class func findAndReplaceExpressions(_ stringToSearch:NSMutableString, expressionName:NSString, expressionEvaluatorBlock:((String?)->AnyObject?)) {
		
		let expressionSearchString = "@\(expressionName)("
		var searchRange = NSMakeRange(0, stringToSearch.length)
		while true {
			
			let startRange = stringToSearch.range(of: expressionSearchString, options: NSString.CompareOptions(), range: searchRange)
			if startRange.location != NSNotFound {
				
				searchRange.location = startRange.location+startRange.length
				searchRange.length = stringToSearch.length-searchRange.location
				
				let endRange = stringToSearch.range(of: ")", options: NSString.CompareOptions(), range: searchRange)
				if endRange.location != NSNotFound {
					
					searchRange.location = endRange.location+endRange.length
					searchRange.length = stringToSearch.length-searchRange.location
					
					let expressionValue = stringToSearch.substring(with: NSMakeRange(startRange.location+startRange.length, endRange.location-(startRange.location+startRange.length)))
					if let replaceValue:AnyObject = expressionEvaluatorBlock(expressionValue) {
						
						let replaceString = "\(replaceValue)" as NSString
						let replaceLength = (endRange.location+endRange.length)-startRange.location
						stringToSearch.replaceCharacters(in: NSMakeRange(startRange.location, replaceLength), with: replaceString as String)
						
						//adjust the search range because we just changed the length / posision of the search range by replacing stuff
						let adjustNum = replaceString.length - replaceLength
						searchRange.location += adjustNum
						searchRange.length = stringToSearch.length-searchRange.location
					}
				}
				else {
					return
				}
			}
			else {
				return
			}
		}
	}
    
    // MARK: - helper methods
    
    // returns an array of all available fonts
    public class func fontNames() -> [String] {
        var names = [String]()
        for family in UIFont.familyNames() as [String] {
            for name in UIFont.fontNames(forFamilyName: family) {
                names.append(name as String)
            }
        }
        return names
    }
	
	public class func GCDDelay(_ delayAmount:Double, block:((Void)->Void)) {
        DispatchQueue.main.after(when: .now() + delayAmount, execute: block)
	}
}
