//
//  SinglePlayerScene.swift
//  TappyBase
//
//  Created by deast on 7/27/15.
//  Copyright (c) 2015 davideast. All rights reserved.
//

import Foundation
import SpriteKit

class SinglePlayerScene: CloudScene {
  
  // Requirements for Single Player
  // - Increasingly spawn FirebaseSprites
  // - Start with 3 lives
  // - Every 30s-60s spawn a 1up life
  // - Record stats for game summary
  // - On lose switch to game over scene w/ summary
  
  // Stats Recording
  // - FirebaseSprites Tapped
  // - Length of time?
  // -
  
  init(size: CGSize) {
    super.init(size: size, backgroundMusic: TappyBaseSounds.backgroundMusic())
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func didMoveToView(view: SKView) {
    super.didMoveToView(view)
  }

  override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
  
    // Tappable nodes (FirebaseSprite, LifeUpSprite, PauseButton)
    

    
  }
  
}