//
//  CloudSprite.swift
//  TappyBase
//
//  Created by deast on 7/25/15.
//  Copyright (c) 2015 davideast. All rights reserved.
//

import Foundation
import SpriteKit

class CloudSprite: SKSpriteNode {
  
  init() {
    let texture = SKTexture(imageNamed: TappyBaseImages.cloudImage())
    super.init(texture: texture, color: nil, size: texture.size())
  }
  
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}