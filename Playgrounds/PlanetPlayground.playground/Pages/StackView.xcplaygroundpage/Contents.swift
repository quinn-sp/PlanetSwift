//#-hidden-code

import UIKit
import PlanetSwift
import PlaygroundSupport

let hostView = setupHostView()

//#-code-completion(everything, hide)
//#-code-completion(snippet, show, equalSpacing, equalSpacing, fill, fillEqually, fillProportionally)

//#-end-hidden-code
/*:
 # Putting Things Together
 UIStackView is a powerful tool for assembling multiple views into a variety of layouts. In PlanetSwift, this element is called StackView.
 
 In this example, you can change the *distribution* attribute to explore how it affects the views. The possible distributions are:
  * equalSpacing 
  * equalSpacing
  * fill
  * fillEqually
  * fillProportionally
 */


let distribution = "fillEqually"

let xml = """
<StackView axis='vertical'
    distribution='\(distribution)'
    frame='0,0,400,600'
    xmlns='http://schema.smallplanet.com/PlanetUI'>
    <Label text='Top'
        fontName='AppleSDGothicNeo-UltraLight'
        textAlignment='center'
        fontSize='60'
        backgroundColor='#eeeeeeff' />
    <Label text='Hello planet!'
        fontName='AppleSDGothicNeo-UltraLight'
        textAlignment='center'
        fontSize='30'
        backgroundColor='#ddddddff' />
    <ImageView image='logo.png'
        contentMode='scaleAspectFit'
        backgroundColor='#ccccccff' />
    <Label text='Bottom'
        fontName='AppleSDGothicNeo-UltraLight'
        textAlignment='center'
        fontSize='30'
        backgroundColor='#bbbbbbff' />
</StackView>
"""

//#-hidden-code

let view = PlanetUI.readFromString(xml)?.asView


hostView.addSubview(view!.view)
PlaygroundPage.current.liveView = hostView

//#-end-hidden-code
