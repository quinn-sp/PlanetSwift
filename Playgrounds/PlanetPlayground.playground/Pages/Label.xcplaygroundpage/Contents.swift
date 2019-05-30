//: [Previous page](@previous) - [Next page](@next)
//#-hidden-code
import UIKit
import PlanetSwift
import PlaygroundSupport

let hostView = setupHostView()

//#-end-hidden-code

let xml = """
<Label text='Hello planet!'
    fontName='AppleSDGothicNeo-UltraLight'
    textAlignment='center'
    fontSize='46'
    frame='0,100,300,100'
    xmlns='http://schema.smallplanet.com/PlanetUI' />
"""

let label = PlanetUI.readFromString(xml)?.asLabel
hostView.addSubview(label!.view)

//#-hidden-code
PlaygroundPage.current.liveView = hostView
//#-end-hidden-code
