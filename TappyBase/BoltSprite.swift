//
//  BoltSprite.swift
//  TappyBase
//
//  Created by deast on 7/28/15.
//  Copyright (c) 2015 davideast. All rights reserved.
//

import Foundation
import SpriteKit

class BoltSprite: SKSpriteNode, TappableNode {
  
  var onTapped: (() -> Void)?
  
  init() {
    let texture = SKTexture(imageNamed: TappyBaseImages.bolt())
    super.init(texture: texture, color: nil, size: texture.size())
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func tappedAction(scene: SKScene) {
    onTapped?()
  }
  
}