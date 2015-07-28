//
//  TappableFirebaseSprite.swift
//  TappyBase
//
//  Created by deast on 7/28/15.
//  Copyright (c) 2015 davideast. All rights reserved.
//

import Foundation
import SpriteKit

class TappableFirebaseSprite: FirebaseSprite {
  
  var onDone: (() -> Void)?
  
  let tappedSound = TappyBaseSounds.firebaseTappedSx()
  let missedSound = TappyBaseSounds.firebaseMissedSx()
  
  init(onTapped: () -> Void, onDone: () -> Void) {
    super.init(size: .Regular)
    self.onTapped = removeOnTap(onTapped)
    self.onDone = removeOnDone(onDone)
  }
  
  func removeOnTap(tappedCallback: (() -> Void)?) -> (() -> Void)? {
    func wrappedCallback() {
      self.removeAllActions()
      let playSoundAction = SKAction.playSoundFileNamed(self.tappedSound, waitForCompletion: false)
      let fadeAction = SKAction.fadeOutWithDuration(0.1)
      self.runAction(SKAction.sequence([fadeAction, playSoundAction, SKAction.removeFromParent()]))
      tappedCallback?()
    }
    return wrappedCallback
  }
  
  func removeOnDone(onDoneCallback: (() -> Void)?) -> (() -> Void)? {
    func wrappedCallback() {
      let playSoundAction = SKAction.playSoundFileNamed(self.missedSound, waitForCompletion: false)
      self.runAction(SKAction.sequence([playSoundAction, SKAction.removeFromParent()]))
      onDoneCallback?()
    }
    return wrappedCallback
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}