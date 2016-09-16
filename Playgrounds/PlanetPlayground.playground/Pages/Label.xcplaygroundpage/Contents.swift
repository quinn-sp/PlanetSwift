//#-hidden-code
import UIKit
import PlanetSwift
import PlaygroundSupport

let hostView = setupHostView()

//#-end-hidden-code

let xml = "<Label text='Hello planet!' fontName='AppleSDGothicNeo-UltraLight' textAlignment='center' fontSize='30'  frame='0,100,300,100' xmlns='http://schema.smallplanet.com/PlanetUI' />"

//#-hidden-code
let label = PlanetUI.readFromString(xml)?.asLabel


hostView.addSubview(label!.view)
PlaygroundPage.current.liveView = hostView

//#-end-hidden-code