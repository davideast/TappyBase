//
//  MainGameScene.swift
//  TappyBase
//
//  Created by deast on 7/15/15.
//  Copyright (c) 2015 davideast. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation

class MainGameScene: SKScene {
  
  var backgroundMusicPlayer: AVAudioPlayer!
  var firebases = [FirebaseSpriteNode]()
  var spawnSpeed = 1.0
  
  let backButton = SKLabelNode(fontNamed: "PressStart2P")
  let livesLabel = SKLabelNode(fontNamed: "PressStart2P")
  let hitsLabel = SKLabelNode(fontNamed: "PressStart2P")
  
  let playersRef = Firebase(url: "https://game-demo.firebaseio-demo.com/game/players")
  let playerSprites = Firebase(url: "https://game-demo.firebaseio-demo.com/game/playerSprites")
  var playerRef: Firebase!
  var playerSpriteRef: Firebase!
  
  var userId: String!
  var activePlayers = [FDataSnapshot]()
  
  var lives = 5
  var hits = 0
  var opponentLives = 5
  var opponentHits = 0
  
  var lastUpdateTimeInterval = NSTimeInterval(0)
  var timeSinceEnemyAdded = NSTimeInterval(0)
  var totalGameTime = NSTimeInterval(0)
  var addEnemyTimeInterval = NSTimeInterval(1.5)
  var minSpeed = 2.0
  
  override func didMoveToView(view: SKView) {
    super.didMoveToView(view)
    
    let topColor = TappyBaseColors.skyBlueCIColor()
    let bottomColor = TappyBaseColors.lightBlueCIColor()
    let bgTexture = textureWithVerticalGradientOfSize(size, topColor: topColor, bottomColor: bottomColor)
    
    let bgNode = SKSpriteNode(texture: bgTexture)
    bgNode.position = CGPointMake(size.width / 2, size.height / 2)
    bgNode.zPosition = -1
    
    addChild(bgNode)
    
    // TESTING CLOUDS
    for index in 0...10 {
      var indexAsDouble = Double(index)
      var xPos = 20.0 * (indexAsDouble * 5.0)
      var yPos = -10.0
      var position = CGPoint(x: xPos, y: yPos)
      let cloud = CloudSprite()
      cloud.position = position
      cloud.anchorPoint = CGPoint(x: 0, y: 0)
      addChild(cloud)
    }
    
    backgroundMusicPlayer = playBackgroundMusic("background-play.wav")
    
    addBackButton()
    addLivesLabel()
    addHitsLabel()
    
    playerRef = playersRef.childByAutoId()
    userId = playerRef.key
    playerRef.setValue([
      "hits": 0,
      "lives": 5,
      "userId": userId
      ])
    playerRef.onDisconnectRemoveValue()
    
    playerSpriteRef = playerSprites.childByAppendingPath(userId)
    
    // Keep players in sync
    playersRef.observeEventType(.Value, withBlock: { snap in
      var newUpdates = [FDataSnapshot]()
      for child in snap.children {
        
        let snapshot = child as! FDataSnapshot
        
        if snapshot.key != self.userId {
          newUpdates.append(snapshot)
          self.opponentLives = snapshot.value.objectForKey("lives") as! Int
          self.opponentHits = snapshot.value.objectForKey("hits") as! Int
          self.livesLabel.text = "\(self.lives) - \(self.opponentLives)"
          self.hitsLabel.text = "\(self.hits) - \(self.opponentHits)"
        }
        
      }
      self.activePlayers = newUpdates
    })
    
    // add a node remotely
    playerSpriteRef.observeEventType(.ChildAdded, withBlock: { snap in
      var node = self.createFirebaseNode()
      node.snapshot = snap
      self.addFirebaseNode(node)
      node.snapshot?.ref.onDisconnectRemoveValue()
    })
    
    // sync opponents stats
    
  }
  
  func spawn() {
    let node = self.createFirebaseNode()
    self.addFirebaseNode(node)
  }
  
  override func willMoveFromView(view: SKView) {
    super.willMoveFromView(view)
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    if let touch = touches.first {
      let touchLocation = touch.locationInNode(self)
      let node = nodeAtPoint(touchLocation)
      
      if node.name == TappyBaseImages.firebaseSprite() {
        
        node.removeAllActions()
        
        let playSoundAction = SKAction.playSoundFileNamed(TappyBaseSounds.firebaseTappedSx(), waitForCompletion: false)
        let fadeAction = SKAction.fadeOutWithDuration(0.1)
        let removeAction = SKAction.runBlock({
          
          node.removeFromParent()
          
          self.hits++
          self.hitsLabel.text = "\(self.hits) - \(self.opponentHits)"
          self.playerRef.updateChildValues(["hits": self.hits])
          if self.hits % 2 == 0 {
            
            if self.activePlayers.count > 0 {
              let lower : UInt32 = 0
              let upper : UInt32 = UInt32(self.activePlayers.count - 1)
              let randomNumber = arc4random_uniform(upper - lower) + lower
              let player = self.activePlayers[Int(randomNumber)]
              let playerKey = player.ref.key
              
              if playerKey != self.userId {
                self.playerSprites.childByAppendingPath(playerKey).childByAutoId().setValue(self.userId)
              }
            }
          }
          
        })
        let sequence = SKAction.sequence([playSoundAction, fadeAction, removeAction])
        
        node.runAction(sequence)
        
      }
      
      if node.name == "back-button" {
        backgroundMusicPlayer.stop()
        self.view?.presentScene(TitleGameScene(size: self.view!.bounds.size))
        self.playerRef.removeValue()
        self.playerSpriteRef.removeValue()
      }
    }
    
  }
  
  func createFirebaseNode() -> FirebaseSpriteNode {
    // Determine where to spawn the monster along the Y axis
    let firebaseNode = SKSpriteNode(imageNamed: TappyBaseImages.firebaseSprite())
    
    // Determine where to spawn the monster along the Y axis
    let actualY = random(min: firebaseNode.size.height/2, max: size.height - firebaseNode.size.height/2)
    
    // Position the monster slightly off-screen along the right edge,
    // and along a random position along the Y axis as calculated above
    let position = CGPoint(x: size.width + firebaseNode.size.width/2, y: actualY)
    
    // Determine speed of the monster
    let actualDuration = random(min: CGFloat(self.minSpeed), max: CGFloat(4.0))
    
    return FirebaseSpriteNode(yAxis: actualY, position: position, duration: actualDuration)
  }
  
  func addFirebaseNode(var node: FirebaseSpriteNode) {
    
    // Create sprite
    let firebaseSprite = SKSpriteNode(imageNamed: TappyBaseImages.firebaseSprite())
    firebaseSprite.name = TappyBaseImages.firebaseSprite()
    firebaseSprite.userInteractionEnabled = false
    
    // add to local array
    node.firebaseNode = FirebaseNode(skNode: firebaseSprite, snapshot: node.snapshot)
    firebases.append(node)
    
    // Determine where to spawn the monster along the Y axis
    let actualY = node.yAxis
    
    // Position the monster slightly off-screen along the right edge,
    // and along a random position along the Y axis as calculated above
    firebaseSprite.position = node.position
    
    // Add the monster to the scene
    addChild(firebaseSprite)
    
    // Determine speed of the monster
    let actualDuration = node.duration
    
    // Create the actions
    let actionMove = SKAction.moveTo(CGPoint(x: -firebaseSprite.size.width/2, y: actualY), duration: NSTimeInterval(actualDuration))
    let actionMoveDone = SKAction.runBlock({
      // remove from screen and possibly firebase
      node.removeFromParent()
      
      // remove a life
      self.lives--
      self.livesLabel.text = "\(self.lives) - \(self.opponentLives)"
      self.playerRef.updateChildValues([ "lives": self.lives ])
      
      // remove a life remotely
      if self.lives == 0 {
        self.playerRef.removeValue()
        self.playerSpriteRef.removeValue()
        self.backgroundMusicPlayer.stop()
        self.view?.presentScene(GameOverScene(size: self.view!.bounds.size, taps: self.hits, stage: 0, duration: 0.0))
      }
    })
    
    let playSoundAction = SKAction.playSoundFileNamed(TappyBaseSounds.firebaseMissedSx(), waitForCompletion: false)
    let loseAction = SKAction.runBlock() {
      
    }
    
    firebaseSprite.runAction(SKAction.sequence([actionMove, playSoundAction, loseAction, actionMoveDone]))
  }
  
  func addBackButton() {
    backButton.text = "Back"
    backButton.fontSize = 18
    backButton.fontColor = TappyBaseColors.darkGrayColor()
    backButton.name = "back-button"
    backButton.position = CGPoint(x: size.width - backButton.frame.width, y: (size.height - backButton.frame.height) - 10)
    backButton.zPosition = CGFloat(1)
    backButton.userInteractionEnabled = false
    addChild(backButton)
  }
  
  func addLivesLabel() {
    livesLabel.text = "\(self.lives) - \(self.opponentLives)"
    livesLabel.fontSize = 18
    livesLabel.fontColor = TappyBaseColors.darkGrayColor()
    livesLabel.name = "lives-label"
    livesLabel.position = CGPoint(x: 75, y: 10)
    livesLabel.zPosition = CGFloat(1)
    livesLabel.userInteractionEnabled = false
    addChild(livesLabel)
  }
  
  func addHitsLabel() {
    hitsLabel.text = "\(self.hits) - \(self.opponentHits)"
    hitsLabel.fontSize = 18
    hitsLabel.fontColor = TappyBaseColors.darkGrayColor()
    hitsLabel.name = "hits-label"
    hitsLabel.position = CGPoint(x: 75, y: (self.size.height - hitsLabel.frame.height) - 10)
    hitsLabel.zPosition = CGFloat(1)
    hitsLabel.userInteractionEnabled = false
    addChild(hitsLabel)
  }
  
  
  override func update(currentTime: NSTimeInterval) {
    
    if ( lastUpdateTimeInterval > NSTimeInterval(0)) {
      totalGameTime += currentTime - lastUpdateTimeInterval
    }
    
    if timeSinceEnemyAdded > addEnemyTimeInterval {
      spawn()
      timeSinceEnemyAdded = 0
    }
    
    lastUpdateTimeInterval = currentTime
    
    // 120 / 60 = 2 minutes
    // 240 / 60 = 4 minutes
    // 480 / 60 = 8 minutes
    
    
    if totalGameTime > 240 {
      
      addEnemyTimeInterval = 0.50
      minSpeed = 1.5
      
    } else if totalGameTime > 120 {
      
      addEnemyTimeInterval = 0.55
      minSpeed = 1.5
      
    } else if totalGameTime > 20 {
      
      addEnemyTimeInterval = 0.65
      minSpeed = 1.5
      
    } else if totalGameTime > 10 {
      
      addEnemyTimeInterval = 0.75
      minSpeed = 2.0
      
    }
    
  }
  
}