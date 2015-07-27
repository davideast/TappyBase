//
//  FirebaseSprite.swift
//  TappyBase
//
//  Created by deast on 7/26/15.
//  Copyright (c) 2015 davideast. All rights reserved.
//

import Foundation
import SpriteKit

enum FirebaseSpriteSize {
  case Small
  case Regular
}

class FirebaseSprite: SKSpriteNode, TappableNode {
  
  init(size: FirebaseSpriteSize = .Regular) {
    
    var imageName = ""
    
    switch size {
    case .Small:
      imageName = TappyBaseImages.firebaseSpriteSmall()
    case .Regular:
      imageName = TappyBaseImages.firebaseSprite()
    }
    
    let texture = SKTexture(imageNamed: imageName)
    super.init(texture: texture, color: nil, size: texture.size())
    name = imageName
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  func tappedAction(scene: SKScene) {
    println(name! + " is tapped")
  }
  
}