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
    
    let sequence = TimeSequence(start: 0.0, end: 5.0, spawnRate: 2.0)
    let otherSeq = TimeSequence(start: 0.0, end: 5.0, spawnRate: 3.0)
    let stageOne = Stage(number: 1, timeSequences: [sequence])
    let stageTwo = Stage(number: 2, timeSequences: [otherSeq])
    stages = [1: stageOne, 2: stageTwo]
    
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
    let waitInterval = SKAction.waitForDuration(5.0)
    let addLifeUpAction = SKAction.runBlock(spawnLifeUp)
    let sequence = SKAction.sequence([waitInterval, addLifeUpAction])
    let spawnLifeUpForever = SKAction.repeatActionForever(sequence)
    runAction(spawnLifeUpForever)
    
  }
  
  // Stages at 100s each
  // 10
  
  func onTimeUpdate(totalGameTime: NSTimeInterval) {
    
    // Check spawn rate for Firebases
    if timeSinceEnemyAdded > spawnRate {
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
        // Incremenet the offset when the stage changes
        offset += stages[currentStage]!.totalTime
        println("offset is \(offset)")
        currentStage++
      }
    } else {
      // Game over?
      println("it boke")
    }
    
    
    //    if totalGameTime < 10 {
    //      spawnRate = 2.0
    //    } else if totalGameTime > 10 && totalGameTime < 20 {
    //      spawnRate = 1.5
    //    } else if totalGameTime > 20 && totalGameTime < 30 {
    //      spawnRate = 0.75
    //    } else if totalGameTime > 30 && totalGameTime < 40 {
    //      spawnRate = 0.6
    //    } else if totalGameTime > 40 && totalGameTime < 50 {
    //      spawnRate = 0.75
    //    } else if totalGameTime > 50 && totalGameTime < 60 {
    //      spawnRate = 0.6
    //    } else if totalGameTime > 60 && totalGameTime < 70 {
    //      spawnRate = 0.7
    //    } else if totalGameTime > 70 && totalGameTime < 80 {
    //      spawnRate = 1.0
    //    } else if totalGameTime > 80 && totalGameTime < 120 {
    //      spawnRate = 0.9
    //    } else if totalGameTime > 120 && totalGameTime < 140 {
    //      spawnRate = 0.85
    //    } else if totalGameTime > 140 && totalGameTime < 160 {
    //      spawnRate = 0.75
    //    } else if totalGameTime > 160 && totalGameTime < 200 {
    //      spawnRate = 0.9
    //    } else if totalGameTime > 200 && totalGameTime < 240 {
    //      spawnRate = 0.8
    //    } else if totalGameTime > 240 && totalGameTime < 260 {
    //      spawnRate = 1.0
    //    } else if totalGameTime > 240 && totalGameTime < 260 {
    //      spawnRate = 0.9
    //    } else if totalGameTime > 260 && totalGameTime < 300 {
    //      spawnRate = 0.85
    //    } else if totalGameTime > 300 && totalGameTime < 360 {
    //      spawnRate = 0.75
    //    } else if totalGameTime > 360 && totalGameTime < 420 {
    //      spawnRate = 0.65
    //    } else if totalGameTime > 420 {
    //      spawnRate = 0.4 // kill-switch
    //    }
    
    // Check if the the totalTime is a multiple of the default interval
    // If so, increase the spawn rate
    //    var flooredTime = floor(totalGameTime)
    //    var mod = flooredTime % self.increaseInterval
    //
    //    if mod == 0 {
    //
    //      var multiple = floor(totalGameTime / increaseInterval)
    //      var decrement = 0.1 * multiple
    //
    //      if multiple >= 0 && addEnemyTimeInterval >= 0 {
    //        addEnemyTimeInterval = 1.0 - decrement
    //      }
    //
    //    }
    
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
    fatalError("lol not implemented")
  }
  
}