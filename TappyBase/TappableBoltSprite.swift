//
//  TappableLifeUpSprite.swift
//  TappyBase
//
//  Created by deast on 7/30/15.
//  Copyright (c) 2015 davideast. All rights reserved.
//

import Foundation
import SpriteKit

typealias BoltSpriteCallback = (sprite: TappableBoltSprite) -> Void

class TappableBoltSprite: BoltSprite, TappableNode {
  
  var onTapped: BoltSpriteCallback?
  
  let tappedSound = TappyBaseSounds.lifeUpSfx()
  
  init(onTapped: BoltSpriteCallback) {
    super.init(size: .Large)
    self.onTapped = wrappedTappedAction(onTapped)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func wrappedTappedAction(tappedCallback: BoltSpriteCallback) -> BoltSpriteCallback  {
    func wrappedCallback(sprite: TappableBoltSprite) -> Void {
      self.removeAllActions()
      let fadeOut = SKAction.fadeOutWithDuration(0.1)
      let playSfx = SKAction.playSoundFileNamed(TappyBaseSounds.lifeUpSfx(), waitForCompletion: false)
      let sequence = SKAction.sequence([playSfx, fadeOut, SKAction.removeFromParent()])
      self.runAction(sequence)
      tappedCallback(sprite: self)
    }
    return wrappedCallback
  }
  
  func tappedAction(scene: SKScene) {
    onTapped?(sprite: self)
  }
  
}