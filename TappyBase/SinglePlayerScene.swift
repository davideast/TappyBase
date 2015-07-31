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
  var addEnemyTimeInterval = NSTimeInterval(2.0) // 2.0 per second
  var player = Player(lives: 3, firebaseSpritesTapped: 0)
  var spawnRateLabel = SKLabelNode(fontNamed: TappyBaseFonts.mainFont())
  
  let stages: [Int: Stage]
  var currentStage = 1
  var offset = 0.0
  
  // HUD
  let smallSprite = BoltSprite()
  var livesLeftNode = SKLabelNode(fontNamed: TappyBaseFonts.mainFont())
  var pauseButton = PauseButton()
  var maskNode: SKSpriteNode!
  
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
  
  var spawnRate: NSTimeInterval {
    get {
      return addEnemyTimeInterval
    }
    set {
      spawnRateLabel.text = newValue.description
      addEnemyTimeInterval = newValue
    }
  }
  
  init(size: CGSize) {
    
    stages = TappyBaseStages.all()
    
    super.init(size: size, backgroundMusic: TappyBaseSounds.backgroundMusic())
    onIntervalUpdate = onTimeUpdate
  }
  
  override func didMoveToView(view: SKView) {
    super.didMoveToView(view)
    
    maskNode = SKSpriteNode(color: UIColor.blackColor(), size: size)
    maskNode.position = CGPointMake(size.width / 2, size.height / 2)
    
    // Create HUD
    displayHUD()
    
    // Set initial lives
    lives = player.lives
    
    // Create life up sprites at specific time interval
    let waitInterval = SKAction.waitForDuration(15.0)
    let addLifeUpAction = SKAction.runBlock(spawnLifeUp)
    let sequence = SKAction.sequence([waitInterval, addLifeUpAction])
    let spawnLifeUpForever = SKAction.repeatActionForever(sequence)
    runAction(spawnLifeUpForever)
    
    // Initial stage label
    
    var stageLabel = SKLabelNode(fontNamed: TappyBaseFonts.mainFont())
    stageLabel.text = "Stage 1"
    stageLabel.position = CGPoint(x: size.width / 2, y: size.height / 2)
    stageLabel.fontSize = 52
    stageLabel.zPosition = 5
    stageLabel.alpha = 0.0
    addChild(stageLabel)
    
    let scaleUp = SKAction.fadeInWithDuration(0.5)
    let scaleDown = SKAction.fadeOutWithDuration(0.3)
    let remove = SKAction.removeFromParent()
    stageLabel.runAction(SKAction.sequence([scaleUp, SKAction.waitForDuration(1.5), scaleDown, remove]))
    
  }
  
  // Stages at 100s each
  // 10?
  
  func onTimeUpdate(totalGameTime: NSTimeInterval) {
    
    // Check spawn rate for Firebases
    // If spawnRate is less than 0 skip the spawn (this is used for presenting/transitioning between stages)
    if timeSinceEnemyAdded > spawnRate && spawnRate > 0.0 {
      spawnFirebase()
      timeSinceEnemyAdded = 0
    }
    
    if let stage = stages[currentStage] {
      
      // Each stage's time sequences are independent of each other
      // To find the correct sequence we need to keep track of the sum of each
      // stage's time length. This sum can be used as an offset to make sure
      // we're operating as if each stage starts from 0
      var offsetTime = totalGameTime - offset
      
      // Get the current sequence in the stage, if stage is over then move to the next stage
      if let currentSequence = stage.sequenceContainingInterval(offsetTime) {
        spawnRate = currentSequence.spawnRate
      } else {
        // Increment the offset when the stage changes
        offset += stages[currentStage]!.totalTime
        currentStage++
        
        var stageLabel = SKLabelNode(fontNamed: TappyBaseFonts.mainFont())
        stageLabel.text = "Stage \(currentStage)"
        stageLabel.position = CGPoint(x: size.width / 2, y: size.height / 2)
        stageLabel.fontSize = 52
        stageLabel.zPosition = 5
        stageLabel.alpha = 0.0
        addChild(stageLabel)
        
        let scaleUp = SKAction.fadeInWithDuration(0.5)
        let scaleDown = SKAction.fadeOutWithDuration(0.3)
        let remove = SKAction.removeFromParent()
        stageLabel.runAction(SKAction.sequence([scaleUp, SKAction.waitForDuration(1.5), scaleDown, remove]))
      }
    } else {
      // Game over?
      println("it boke")
    }
    
  }
  
  func spawnFirebase() {
    
    // Create a Sprite that increments taps when tapped and
    // removes a life when FirebaseSprite moves across the screen w/out a tap
    let firebaseSprite = TappableFirebaseSprite(onTapped: { _ in
      self.firebasesTapped++
      }, onDone: {
        //self.lives--
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
    
    smallSprite.anchorPoint = CGPoint(x: 0, y: 0)
    smallSprite.position = CGPoint(x: size.width - (smallSprite.size.width + livesLeftNode.frame.size.width + 70), y: size.height - (smallSprite.size.height + 20))
    
    livesLeftNode.position = CGPoint(x: size.width - (livesLeftNode.frame.size.width + 40), y: size.height - (smallSprite.size.height + 12))
    livesLeftNode.fontSize = 20
    
    pauseButton.anchorPoint = CGPoint(x: 0, y: 0)
    pauseButton.position = CGPoint(x: size.width - (pauseButton.size.width + 20), y: 10)
    pauseButton.zPosition = 3
    
    pauseButton.onTapped = {
      self.paused = !self.paused
      
      if self.paused {
        self.maskNode.alpha = 0.3
        self.maskNode.zPosition = 2
        self.addChild(self.maskNode)
      } else {
        self.maskNode.removeFromParent()
      }
    }
    
    spawnRateLabel.position = CGPoint(x: spawnRateLabel.frame.width + 60, y: size.height - 50)
    
    addChild(smallSprite)
    addChild(livesLeftNode)
    addChild(pauseButton)
    addChild(spawnRateLabel)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("ಠ︵ಠ凸")
  }
  
}