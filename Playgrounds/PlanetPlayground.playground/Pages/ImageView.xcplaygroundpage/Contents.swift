//: [Previous page](@previous) - [Next page](@next)
//#-hidden-code
import UIKit
import PlanetSwift
import PlaygroundSupport

let hostView = setupHostView()

//#-end-hidden-code

let xml = """
<ImageView xmlns='http://schema.smallplanet.com/PlanetUI'
    frame='100,100,166,80'
    image='logo.png'
    contentMode='aspectFit'
    />
"""

//#-hidden-code

let imageView = PlanetUI.readFromString(xml)?.asImageView


hostView.addSubview(imageView!.view)
PlaygroundPage.current.liveView = hostView

//#-end-hidden-code
