//: [Previous](@previous)

import UIKit
import PlanetSwift
import PlaygroundSupport

let hostView = setupHostView()

// Set system styles
let styles = "<?xml version='1.0' encoding='UTF-8'?>" +
"<Object id='styles' xmlns='http://schema.smallplanet.com/PlanetUI'>" +
"<Label styleId='LabelLight' fontName='AppleSDGothicNeo-UltraLight' fontSize='30' textAlignment='center' />" +
"<Label styleId='LabelBold' fontName='AppleSDGothicNeo-Bold' fontSize='30' textColor='#4444BBFF' textAlignment='center'/>" +
"</Object>"

Object.loadStylesFromString(styles)

let xml = "<StackView axis='vertical' distribution='fillEqually' frame='0,0,300,400' xmlns='http://schema.smallplanet.com/PlanetUI'>" +
    "<Label text='Top' styleId='LabelLight' />" +
    "<Label text='Hello planet!' styleId='LabelBold' />" +
    "<Label text='Bottom' fontName='AmericanTypewriter-Light' styleId='LabelLight' textColor='#ff0000ff' />" +
    "</StackView>"

let view = PlanetUI.readFromString(xml, prepare: true)?.asView
view?.visit { $0.gaxbDidPrepare() }

hostView.addSubview(view!.view)
PlaygroundPage.current.liveView = hostView


//: [Next](@next)
