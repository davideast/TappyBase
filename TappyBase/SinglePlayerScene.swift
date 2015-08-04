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
  
  let increaseInterval = 20.0
  var addEnemyTimeInterval = NSTimeInterval(2.0) // 2.0 per second
  var player = Player(lives: 3, firebaseSpritesTapped: 0)
  var spawnRateLabel = SKLabelNode(fontNamed: TappyBaseFonts.mainFont())
  
  let stages: [Int: Stage]
  var currentStage = 1
  var offset = 0.0
  var spawnAmount = 1
  var lastPause: NSTimeInterval = 0.0
  var lastResume: NSTimeInterval = 0.0
  var gameOverTime: NSTimeInterval = 0.0
  
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
  
  var firebaseNodes: [TappableFirebaseSprite] {
    get {
      var sprites = [TappableFirebaseSprite]()
      for sprite in children {
        if let sprite = sprite as? TappableFirebaseSprite {
          sprites.append(sprite)
        }
      }
      return sprites
    }
  }
  
  // Each stage's time sequences are independent of each other
  // To find the correct sequence we need to keep track of the sum of each
  // stage's time length. This sum can be used as an offset to make sure
  // we're operating as if each stage starts from 0. Since the user can
  // also pause the game we need to keep track of how much time has been
  // paused and subtract that from the total game time and THEN subtract
  // the stage offset.
  var offsetTime: NSTimeInterval {
    get {
      return (totalGameTime - pausedOffset) - offset
    }
  }
  
  var pausedOffset: NSTimeInterval = 0.0
  
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
    
    let swipeDown = UISwipeGestureRecognizer(target: self, action: Selector("swipedDown:"))
    swipeDown.direction = .Down
    view.addGestureRecognizer(swipeDown)
    
  }
  
  func onTimeUpdate(totalGameTime: NSTimeInterval) {
    
    if paused {
      return
    }
    
    // Check spawn rate for Firebases
    // If spawnRate is less than 0 skip the spawn (this is used for presenting/transitioning between stages)
    if timeSinceEnemyAdded > spawnRate && spawnRate > 0.0 {
      spawnFirebase(spawnAmount)
      timeSinceEnemyAdded = 0
    }
    
    if let stage = stages[currentStage] {
      
      // Get the current sequence in the stage, if stage is over then move to the next stage
      if let currentSequence = stage.sequenceContainingInterval(offsetTime) {
        spawnRate = currentSequence.spawnRate
        spawnAmount = currentSequence.spawnAmount
      } else {
        // Increment the offset when the stage changes
        offset += stages[currentStage]!.totalTime
        currentStage++
        
        // TODO: Refactor to subclassed node
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
        
        // TODO: refactor stage property to a computed on the Scene
        // (example): if let upcomingStage = stage { }
        if let upcomingStage = stages[currentStage] {
          
          // Check for background colorization
          if let stageColor = upcomingStage.stageColor {
            bgNode.runAction(SKAction.colorizeWithColor(stageColor.color, colorBlendFactor: stageColor.blendFactor, duration: 2.0))
          }
          
          cloudSpeed = upcomingStage.cloudSpeed
          
        }
        
      }
    } else {
      // Game over?
      println("it boke")
    }
    
  }
  
  func spawnFirebase(var amount: Int) {
    
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

    amount--
    
    if amount > 0 {
      spawnFirebase(amount)
    }
    
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
    gameOverTime = offsetTime
    backgroundMusicPlayer.stop()
    view?.presentScene(GameOverScene(size: self.view!.bounds.size, taps: player.firebaseSpritesTapped, stage: currentStage, duration: gameOverTime))
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
      let isPaused = !self.paused
      
      if isPaused {
        self.pauseGame()
        self.maskNode.alpha = 0.3
        self.maskNode.zPosition = 2
        self.addChild(self.maskNode)
      } else {
        self.unpauseGame()
        self.maskNode.removeFromParent()
      }
    }
    
    spawnRateLabel.position = CGPoint(x: spawnRateLabel.frame.width + 60, y: size.height - 50)
    
    addChild(smallSprite)
    addChild(livesLeftNode)
    addChild(pauseButton)
    // addChild(spawnRateLabel)
  }
  
  func pauseGame() {
    lastPause = totalGameTime
    paused = true
  }
  
  func unpauseGame() {
    lastResume = totalGameTime
    pausedOffset += lastResume - lastPause
    paused = false
  }
  
  func swipedDown(sender: UISwipeGestureRecognizer) {
    if lives <= 1 {
      return
    }
    
    let powerMove = SKAction.runBlock({
      for sprite in self.firebaseNodes {
        let fbSprite: TappableFirebaseSprite = sprite as TappableFirebaseSprite
        let fadeAction = SKAction.fadeOutWithDuration(0.1)
        fbSprite.runAction(SKAction.sequence([fadeAction, SKAction.removeFromParent()]))
        self.firebasesTapped++
      }
    })
    let removeLife = SKAction.runBlock({
      self.lives--
    })
    runAction(SKAction.sequence([powerMove, removeLife]))
  }
  
  func doubleTapped(sender: UITapGestureRecognizer) {
    println("double tapped")
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("ಠ︵ಠ凸")
  }
  
}