//
//  SinglePlayerScene.swift
//  TappyBase
//
//  Created by deast on 7/27/15.
//  Copyright (c) 2015 davideast. All rights reserved.
//
//  Previous Scene: TitleScene or GameOverScene
//  Next Scene: GameOverScene

import GameKit
import SpriteKit

class SinglePlayerScene: CloudScene {
  
  let increaseInterval = 20.0
  var addEnemyTimeInterval = NSTimeInterval(2.0) // 2.0 per second
  var player = LocalPlayer(localPlayer: GKLocalPlayer.localPlayer())
  var spawnRateLabel = SKLabelNode(fontNamed: TappyBaseFonts.mainFont())
  
  let stages: [Int: Stage]
  var currentStage = 1
  var offset = 0.0
  var spawnAmount = 1
  var lastPause: NSTimeInterval = 0.0
  var lastResume: NSTimeInterval = 0.0
  var gameOverTime: NSTimeInterval = 0.0
  
  // HUD
  var mainHUD: SinglePlayerHud!
  
  var lives: Int {
    get {
      return player.lives
    }
    set {
      player.lives = newValue
      mainHUD.livesLeftNode.text = newValue.description
      
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
      return children.filter({
        return $0 is TappableFirebaseSprite
      }) as! [TappableFirebaseSprite]
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
    
    mainHUD = SinglePlayerHud(size: size, onPausedTapped: { hud in
      let isPaused = !self.paused
      
      if isPaused {
        self.pauseGame()
        hud.showPausedScreen()
      } else {
        self.unpauseGame()
        hud.unshowPausedScreen()
      }
    })
    addChild(mainHUD)
    
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
    swipeDown.numberOfTouchesRequired = 2
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
    // The sum of the completed stage times plus the current offset time
    gameOverTime = cumulativeStageTime(currentStage) + offsetTime
    backgroundMusicPlayer.stop()
    view?.presentScene(GameOverScene(size: self.view!.bounds.size, taps: player.firebaseSpritesTapped, stage: currentStage, duration: gameOverTime))
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
  
  func goHome() {
    view?.presentScene(TitleGameScene(size: size))
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
  
  // Return the sum of the time of each stage up until the provided stage number.
  // The stageNumber provided is not added to the sum because it has not been completed.
  func cumulativeStageTime(stageNumber: Int) -> NSTimeInterval {
    
    if stageNumber <= 1 {
      return 0.0
    }
    
    var cumulativeTime = 0.0
    for index in 1...stageNumber-1 {
      if let stage = stages[index] {
        cumulativeTime += stage.totalTime
      }
    }
    
    return cumulativeTime
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("ಠ︵ಠ凸")
  }
  
}