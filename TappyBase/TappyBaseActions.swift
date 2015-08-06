//
//  TappyBaseActions.swift
//  TappyBase
//
//  Created by deast on 8/6/15.
//  Copyright (c) 2015 davideast. All rights reserved.
//

import SpriteKit

struct TappyBaseActions {
  
  static func glow() -> SKAction {
    let dimAction = SKAction.fadeAlphaTo(0.15, duration: 0.5)
    let brightenAction = SKAction.fadeAlphaTo(1.0, duration: 0.5)
    let glowingSequence = SKAction.sequence([dimAction, brightenAction])
    let glowForever = SKAction.repeatActionForever(glowingSequence)
    return glowForever
  }
  
}
