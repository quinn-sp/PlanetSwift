//: [Previous](@previous)

import UIKit
import PlanetSwift
import PlaygroundSupport

let hostView = setupHostView()

//let distribution = "equalSpacing"
//let distribution = "equalCentering"
//let distribution = "fill"
//let distribution = "fillEqually"
let distribution = "fillProportionally"

let xml = "<StackView axis='vertical' distribution='\(distribution)' frame='0,0,300,400' xmlns='http://schema.smallplanet.com/PlanetUI'>" +
    "<Label text='Top' fontName='AppleSDGothicNeo-UltraLight' textAlignment='center' fontSize='60' backgroundColor='#eeeeeeff' />" +
    "<Label text='Hello planet!' fontName='AppleSDGothicNeo-UltraLight' textAlignment='center' fontSize='30' backgroundColor='#ddddddff' />" +
    "<ImageView image='logo.png' contentMode='scaleAspectFit' backgroundColor='#ccccccff' />" +
    "<Label text='Bottom' fontName='AppleSDGothicNeo-UltraLight' textAlignment='center' fontSize='30' backgroundColor='#bbbbbbff' />" +
"</StackView>"

let view = PlanetUI.readFromString(xml)?.asView


hostView.addSubview(view!.view)
PlaygroundPage.current.liveView = hostView

//: [Next](@next)
