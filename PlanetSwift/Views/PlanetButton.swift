//
//  PlanetButton.swift
//  PlanetSwift
//
//  Created by Nicholas Bowlin on 1/21/15.
//  Copyright (c) 2015 Small Planet. All rights reserved.
//

import Foundation
import UIKit

public class PlanetButton: UIButton {
    var button: Button?
    
    func setupButton(button: Button) {
        
        self.button = button
        
        if button.backgroundColor != nil {
            self.backgroundColor = button.backgroundColor
        }
        
        self.addTarget(self, action: "handleTouchDown", forControlEvents: .TouchDown)
        self.addTarget(self, action: "handleTouchUp", forControlEvents: .TouchUpInside)
    }
    
    func handleTouchDown() {
        if let tempButton = button {
            var tempColor: UIColor?
            
            if tempButton.isToggle {
                if backgroundColor == tempButton.backgroundColor {
                    tempColor = tempButton.backgroundColorHighlighted
                }
                else {
                    tempColor = tempButton.backgroundColorSelectedHighlighted
                }
            }
            else {
                tempColor = tempButton.backgroundColorHighlighted
            }
            
            if tempColor != nil {
                backgroundColor = tempColor
            }
        }
    }
    
    func handleTouchUp() {
        if let tempButton = button {
            var tempColor: UIColor?
            if tempButton.isToggle {
                selected = !selected
                
                if backgroundColor == tempButton.backgroundColorHighlighted {
                    tempColor = tempButton.backgroundColorSelected
                }
                else {
                    tempColor = tempButton.backgroundColor
                }
            }
            else {
                tempColor = tempButton.backgroundColor
            }
            
            if tempColor != nil {
                backgroundColor = tempColor
            }
        }
    }
}