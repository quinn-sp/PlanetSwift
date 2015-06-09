//
// Autogenerated by gaxb at 01:09:14 PM on 01/21/15
//

import UIKit

public class Controller: ControllerBase {

	public weak var controllerObject: UIViewController? {
		didSet {
			
			if oldValue != nil {
				for notification in self.notifications {
                    let (_, name) = self.parseNotification(notification.scopedName)
					if name != nil {
						NSNotificationCenter.defaultCenter().removeObserver(oldValue!, name: notification.name, object: notification.scopeObject)
					}
				}
			}
			
			for notification in self.notifications {
				if let selector = notification.selector {
					NSNotificationCenter.defaultCenter().addObserver(controllerObject!, selector: selector, name: notification.name, object: notification.scopeObject)
				}
			}
		}
	}
}
