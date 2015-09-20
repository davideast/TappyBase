//
//  BoltSprite.swift
//  TappyBase
//
//  Created by deast on 7/28/15.
//  Copyright (c) 2015 davideast. All rights reserved.
//

import Foundation
import SpriteKit

enum BoltSpriteSize {
  case Small
  case Large
}

class BoltSprite: SKSpriteNode {

  
  init(size: BoltSpriteSize = .Small) {
    
    var imageName = ""
    
    switch size {
    case .Small:
      imageName = TappyBaseImages.bolt()
    case .Large:
      imageName = TappyBaseImages.boltLarge()
    }
    
    let texture = SKTexture(imageNamed: imageName)
    super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
    name = imageName
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}