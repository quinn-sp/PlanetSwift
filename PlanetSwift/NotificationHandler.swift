//
//  NotificationHandler.swift
//  PlanetSwift
//
//  Created by Quinn McHenry on 9/4/15.
//  Copyright © 2015 Small Planet. All rights reserved.
//

// Sample implementation:
//
//  enum Notification: String, NotificationHandler {
//      case SomethingImportant
//      case SystemTimeChanged
//    
//      var name: String {
//          switch self {
//          case .SystemTimeChanged: return NSSystemClockDidChangeNotification
//          default: return rawValue
//          }
//      }
//  }
//
// Sample usage:
//    Notification.SomethingImportant.observe(self, selector: Selector("importantHandler:"))
//    ...
//    Notification.SomethingImportant.post()


import Foundation

public protocol NotificationHandler {
    var name: String { get }
    func post(object: AnyObject?, userInfo: [NSObject : AnyObject]?)
    func observe(observer: AnyObject, selector: Selector, object: AnyObject?)
    func remove(observer: AnyObject, object: AnyObject?)
    static func remove(observer: AnyObject)
}

public extension NotificationHandler {
    
    func post(object: AnyObject? = nil, userInfo: [NSObject : AnyObject]? = nil) {
        NSNotificationCenter.defaultCenter().postNotificationName(name, object: object, userInfo: userInfo)
    }
    func observe(observer: AnyObject, selector: Selector, object: AnyObject? = nil) {
        NSNotificationCenter.defaultCenter().addObserver(observer, selector: selector, name: name, object: object)
    }
    func remove(observer: AnyObject, object: AnyObject? = nil) {
        NSNotificationCenter.defaultCenter().removeObserver(observer, name: name, object: object)
    }
    static func remove(observer: AnyObject) {
        NSNotificationCenter.defaultCenter().removeObserver(observer)
    }
    
}
