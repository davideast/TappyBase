//
//  MultiplayerScene.swift
//  TappyBase
//
//  Created by deast on 8/5/15.
//  Copyright (c) 2015 davideast. All rights reserved.
//

import SpriteKit
import GameKit

class MultiplayerScene: SinglePlayerScene {
  
  let gameManager: GameManager
  
  init(size: CGSize, match: Match) {
    gameManager = GameManager(match: match)
    super.init(size: size)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func didMoveToView(view: SKView) {
    super.didMoveToView(view)
    
    if gameManager.match.firstToGetHotPotato == gameManager.match.localPlayer.id {
      let waitToAddHotPotatoSequence = SKAction.sequence([
        SKAction.waitForDuration(6.0),
        SKAction.runBlock(spawnHotPotatoFirebase)
      ])
      runAction(waitToAddHotPotatoSequence)
    }
    
    gameManager.listenForHotPotatoes {
      self.spawnHotPotatoFirebase()
    }
    
    // No pausing in multiplayer
    mainHUD.pauseButton.removeFromParent()
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    super.touchesBegan(touches, withEvent: event)
  }
  
  func spawnHotPotatoFirebase() {
    // Create a Sprite that increments taps when tapped and
    // removes a life when FirebaseSprite moves across the screen w/out a tap
    let hotPotatoSprite = HotPotatoSprite(onTapped: { _ in
      self.firebasesTapped++
      self.gameManager.sendHotPotatoToOpponent()
      }, onDone: {
        self.gameOver()
        self.gameManager.gameOver()
    })
    
    moveFromLeft(hotPotatoSprite, size: size, durationMin: 1.5, durationMax: 2.3, onDone: {
      hotPotatoSprite.onDone?()
    })
    
    addChild(hotPotatoSprite)
  }
  
  
}
