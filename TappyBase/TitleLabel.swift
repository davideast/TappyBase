//
//  TitleLabel.swift
//  TappyBase
//
//  Created by deast on 7/27/15.
//  Copyright (c) 2015 davideast. All rights reserved.
//

import Foundation
import SpriteKit

class TitleLabel: SKSpriteNode {
  
  init() {
    let texture = SKTexture(imageNamed: TappyBaseImages.titleImage())
    super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
    name = TappyBaseImages.titleImage()
    zPosition = CGFloat(1)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  
}