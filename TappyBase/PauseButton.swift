//
//  PauseButton.swift
//  TappyBase
//
//  Created by deast on 7/30/15.
//  Copyright (c) 2015 davideast. All rights reserved.
//

import Foundation
import SpriteKit

class PauseButton: SKSpriteNode, TappableNode {
  
  var onTapped: (() -> Void)?
  
  init() {
    let texture = SKTexture(imageNamed: TappyBaseImages.pauseButton())
    super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func tappedAction(scene: SKScene) {
    onTapped?()
  }
  
}