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
  
  var onTapped: () -> ()
  
  init(onTapped: () -> ()) {
    self.onTapped = onTapped
    super.init()
    fontName = TappyBaseFonts.mainFont()
    text = "Play"
    fontSize = 40
    fontColor = TappyBaseColors.darkGrayColor()
    name = "play-button"
    zPosition = CGFloat(1)
    userInteractionEnabled = false
  }

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  func tappedAction(scene: SKScene) {
    onTapped()
  }
  
}