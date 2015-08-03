//
//  ReplayButton.swift
//  TappyBase
//
//  Created by deast on 8/3/15.
//  Copyright (c) 2015 davideast. All rights reserved.
//

import Foundation
import SpriteKit

class TappableMainLabel: SKLabelNode, TappableNode {
  
  var onTapped: VoidCallback
  
  init(text: String, onTapped: VoidCallback) {
    self.onTapped = onTapped
    super.init(fontNamed: TappyBaseFonts.mainFont())
    self.text = text
    self.name = "replay-button"
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func tappedAction(scene: SKScene) {
    onTapped()
  }
  
}