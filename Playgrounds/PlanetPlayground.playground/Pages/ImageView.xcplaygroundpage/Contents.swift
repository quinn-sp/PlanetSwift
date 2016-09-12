//: [Previous](@previous)

import UIKit
import PlanetSwift
import PlaygroundSupport

let hostView = setupHostView()



let xml = "<ImageView xmlns='http://schema.smallplanet.com/PlanetUI' frame='100,100,100,100' image='logo.png' />"

let imageView = PlanetUI.readFromString(xml)?.asImageView


hostView.addSubview(imageView!.view)
PlaygroundPage.current.liveView = hostView

//: [Next](@next)
