import UIKit

public func setupHostView() -> UIView {
    let hostView = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 600))
    
    hostView.layer.borderWidth = 1
    hostView.layer.borderColor = UIColor.blue.cgColor
    hostView.backgroundColor = UIColor.white
    return hostView
}
