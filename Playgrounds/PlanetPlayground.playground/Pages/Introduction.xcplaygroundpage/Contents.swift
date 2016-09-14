//: Playground - noun: a place where people can play

import UIKit
import PlanetSwift
import PlaygroundSupport

let hostView = setupHostView()



let xml = "<View xmlns='http://schema.smallplanet.com/PlanetUI' frame='100,100,100,100' backgroundColor='red'/>"

let v = PlanetUI.readFromString(xml)?.asView



hostView.addSubview(v!.view)
PlaygroundPage.current.liveView = hostView

//: [Next](@next)
