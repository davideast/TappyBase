//
//  PlayButton.swift
//  TappyBase
//
//  Created by deast on 7/27/15.
//  Copyright (c) 2015 davideast. All rights reserved.
//

import Foundation
import SpriteKit

class PlayButton : SKLabelNode, TappableNode {
  
  var onTapped: () -> Void
  
  init(text: String, name: String, onTapped: () -> Void) {
    self.onTapped = onTapped
    super.init()
    fontName = TappyBaseFonts.mainFont()
    self.text = text
    fontSize = 40
    fontColor = TappyBaseColors.darkGrayColor()
    self.name = name
    zPosition = 1.0
    userInteractionEnabled = false
  }

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  func tappedAction(scene: SKScene) {
    onTapped()
  }
  
}