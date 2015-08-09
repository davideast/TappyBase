//
//  HotPotatoSprite.swift
//  TappyBase
//
//  Created by David East on 8/9/15.
//  Copyright (c) 2015 davideast. All rights reserved.
//

import SpriteKit

class HotPotatoSprite: TappableFirebaseSprite {
  
  override init(onTapped: () -> Void, onDone: () -> Void) {
    super.init(onTapped: onTapped, onDone: onDone)
    let changeColor = SKAction.colorizeWithColor(TappyBaseColors.redSkyColor(), colorBlendFactor: 0.5, duration: 0.0)
    runAction(changeColor)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
