//
//  SinglePlayerScene.swift
//  TappyBase
//
//  Created by deast on 7/27/15.
//  Copyright (c) 2015 davideast. All rights reserved.
//
//  Previous Scene: TitleScene or GameOverScene
//  Next Scene: GameOverScene

import Foundation
import SpriteKit

class SinglePlayerScene: CloudScene {
  
  // Requirements for Single Player
  // - Increasingly spawn FirebaseSprites
  // - Start with 3 lives
  // - Every 30s-60s spawn a 1up life
  // - Record stats for game summary
  // - On lose switch to game over scene w/ summary
  
  // Tappable nodes 
  // - FirebaseSprite
  // - LifeUpSprite
  // - PauseButton
  
  // Stats Recording
  // - FirebaseSprites Tapped
  // - Length of time?
  
  let increaseInterval = 30.0
  var addEnemyTimeInterval = NSTimeInterval(1.5) // 1.5 per second
  var player = Player(lives: 3)
  
  init(size: CGSize) {
    super.init(size: size, backgroundMusic: TappyBaseSounds.backgroundMusic())
    
    onIntervalUpdate = { currentTime in
      
      if self.timeSinceEnemyAdded > self.addEnemyTimeInterval {
        self.spawn()
        self.timeSinceEnemyAdded = 0
      }
      
      var flooredTime = floor(currentTime)
      var mod = flooredTime % self.increaseInterval

      if mod == 0 {
        
        var multiple = floor(currentTime / self.increaseInterval)
        var decrement = 0.1 * multiple
        
        if multiple > 0 && self.addEnemyTimeInterval >= 0 {
          self.addEnemyTimeInterval = 1.0 - decrement
        }
        
      }

    }
    
  }
  
  func spawn() {
    let firebaseSprite = FirebaseSprite()
    moveFromLeft(firebaseSprite, size, 1.5, 2.3)
    addChild(firebaseSprite)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func didMoveToView(view: SKView) {
    super.didMoveToView(view)
  }
  
}