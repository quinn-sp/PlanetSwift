//#-hidden-code
import UIKit
import PlanetSwift
import PlaygroundSupport

let hostView = setupHostView()

//#-end-hidden-code

let xml = "<ImageView xmlns='http://schema.smallplanet.com/PlanetUI' frame='100,100,100,100' image='logo.png' />"

//#-hidden-code

let imageView = PlanetUI.readFromString(xml)?.asImageView


hostView.addSubview(imageView!.view)
PlaygroundPage.current.liveView = hostView

//#-end-hidden-code