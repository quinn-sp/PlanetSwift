//#-hidden-code
import UIKit
import PlanetSwift
import PlaygroundSupport

let hostView = setupHostView()

//#-end-hidden-code

/*:
 # Welcome! 
 PlanetSwift is an opensource framework that provides a new layout option to compliment Interface Builder and code-only approaches.
 
 Using simple XML files, you can create complex view hierarchies. This playground book allows you to explore the capabilities of PlanetSwift, learn the basics, and play!
*/

let xml = "<View frame='100,100,100,100' backgroundColor='red' xmlns='http://schema.smallplanet.com/PlanetUI' />"

//#-hidden-code
let v = PlanetUI.readFromString(xml)?.asView

hostView.addSubview(v!.view)
PlaygroundPage.current.liveView = hostView
//#-end-hidden-code