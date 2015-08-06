//
//  FadingLabel.swift
//  TappyBase
//
//  Created by deast on 8/6/15.
//  Copyright (c) 2015 davideast. All rights reserved.
//

import SpriteKit

class FadingLabel: SKLabelNode {
  
  override init() {
    super.init()
    runAction(glow())
  }
  
  override init(fontNamed fontName: String!) {
    super.init(fontNamed: fontName)
    runAction(glow())
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func glow() -> SKAction {
    let dimAction = SKAction.fadeAlphaTo(0.15, duration: 0.5)
    let brightenAction = SKAction.fadeAlphaTo(1.0, duration: 0.5)
    let glowingSequence = SKAction.sequence([dimAction, brightenAction])
    let glowForever = SKAction.repeatActionForever(glowingSequence)
    return glowForever
  }
  
}
