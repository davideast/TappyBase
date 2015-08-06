//
//  MultiplayerScene.swift
//  TappyBase
//
//  Created by deast on 8/5/15.
//  Copyright (c) 2015 davideast. All rights reserved.
//

import SpriteKit

class MultiplayerScene: SinglePlayerScene {
 
  override init(size: CGSize) {
    super.init(size: size)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func didMoveToView(view: SKView) {
    super.didMoveToView(view)
    
    // No pausing in multiplayer
    mainHUD.pauseButton.removeFromParent()
  }
  
  override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
    super.touchesBegan(touches, withEvent: event)
    
    if hasTappedAMultipleOf(3) {
      // TODO: Inform Firebase game node that the other player gets a base added to their screen
      spawnFirebase(1)
    }
    
  }
  
  func hasTappedAMultipleOf(multiple: Int) -> Bool {
    return firebasesTapped % multiple == 0
  }
  
  
}
