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
  
  let increaseInterval = 20.0
  var addEnemyTimeInterval = NSTimeInterval(1.5) // 1.5 per second
  var player = Player(lives: 30, firebaseSpritesTapped: 0)
  
  // HUD
  let smallSprite = BoltSprite()
  var livesLeftNode = SKLabelNode(fontNamed: TappyBaseFonts.mainFont())
  
  var lives: Int {
    get {
      return player.lives
    }
    set {
      player.lives = newValue
      livesLeftNode.text = newValue.description
      
      if newValue == 0 {
        gameOver()
      }
      
    }
  }
  
  var firebasesTapped: Int {
    get {
      return player.firebaseSpritesTapped
    }
    set {
      player.firebaseSpritesTapped = newValue
    }
  }
  
  init(size: CGSize) {
    super.init(size: size, backgroundMusic: TappyBaseSounds.backgroundMusic())
    onIntervalUpdate = onTimeUpdate
  }
  
  override func didMoveToView(view: SKView) {
    super.didMoveToView(view)
    
    // Create HUD
    displayHUD()
    
    // Set initial lives
    lives = player.lives
    
    // Create life up sprites at specific time interval
    let waitInterval = SKAction.waitForDuration(5.0)
    let addLifeUpAction = SKAction.runBlock(spawnLifeUp)
    let sequence = SKAction.sequence([waitInterval, addLifeUpAction])
    let spawnLifeUpForever = SKAction.repeatActionForever(sequence)
    runAction(spawnLifeUpForever)
    
  }
  
  func onTimeUpdate(totalGameTime: NSTimeInterval) {
    
    // Check spawn rate for Firebases
    if timeSinceEnemyAdded > addEnemyTimeInterval {
      spawnFirebase()
      timeSinceEnemyAdded = 0
    }
    
    // Check if the the totalTime is a multiple of the default interval
    // If so, increase the spawn rate
    var flooredTime = floor(totalGameTime)
    var mod = flooredTime % self.increaseInterval
    
    if mod == 0 {
      
      var multiple = floor(totalGameTime / increaseInterval)
      var decrement = 0.1 * multiple
      
      if multiple >= 0 && addEnemyTimeInterval >= 0 {
        addEnemyTimeInterval = 1.0 - decrement
      }
      
    }
    
  }
  
  func spawnFirebase() {
    
    // Create a Sprite that increments taps when tapped and
    // removes a life when FirebaseSprite moves across the screen w/out a tap
    let firebaseSprite = TappableFirebaseSprite(onTapped: { _ in
      self.firebasesTapped++
    }, onDone: {
      self.lives--
    })
    
    moveFromLeft(firebaseSprite, size, 1.5, 2.3, {
      firebaseSprite.onDone?()
    })
    
    addChild(firebaseSprite)
  }
  
  func spawnLifeUp() {
    let lifeUpSprite = TappableBoltSprite { _ in
      self.lives++
    }
    moveFromLeft(lifeUpSprite, size, 1.0, 2.0) {
      lifeUpSprite.removeFromParent()
    }
    addChild(lifeUpSprite)
  }
  
  func gameOver() {
    backgroundMusicPlayer.stop()
    view?.presentScene(GameOverScene(size: self.view!.bounds.size, hits: player.firebaseSpritesTapped))
  }
  
  func displayHUD() {
    
    smallSprite.position = CGPoint(x: size.width - (smallSprite.size.width + livesLeftNode.frame.size.width + 70), y: size.height - (smallSprite.size.height + 20))
    
    livesLeftNode.position = CGPoint(x: size.width - (livesLeftNode.frame.size.width + 40), y: size.height - (smallSprite.size.height + 12))
    
    livesLeftNode.fontSize = 20
    
    smallSprite.anchorPoint = CGPoint(x: 0, y: 0)
    
    addChild(smallSprite)
    addChild(livesLeftNode)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
}