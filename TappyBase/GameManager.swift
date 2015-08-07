//
//  GameManager.swift
//  TappyBase
//
//  Created by deast on 8/6/15.
//  Copyright (c) 2015 davideast. All rights reserved.
//

import SpriteKit

typealias TappableFirebaseCallback = (sprite: TappableFirebaseSprite) -> Void

struct GameManager {
  
  let gameRef: Firebase
  let localPlayerRef: Firebase
  let opponentRef: Firebase
  let opponentSpriteQueueRef: Firebase
  let localSpriteQueueRef: Firebase
  // let onItemAdded: TappableFirebaseCallback
  
  init(gameId: String, localPlayerId: String, opponentId: String, onItemAdded: TappableFirebaseCallback) {
    let url = "https://tappybase.firebaseio.com"
    gameRef = Firebase(url: "\(url)/games/\(gameId)")
    localPlayerRef = gameRef.childByAppendingPath(localPlayerId)
    opponentRef = gameRef.childByAppendingPath(opponentId)
    opponentSpriteQueueRef = gameRef.childByAppendingPath("spriteQueue").childByAppendingPath(opponentId)
    localSpriteQueueRef = gameRef.childByAppendingPath("spriteQueue").childByAppendingPath(localPlayerId)
    // self.onItemAdded = onItemAdded
    
    localSpriteQueueRef.observeEventType(.ChildAdded, withBlock: { data in
        // TODO: deserialize to TappableSprite and call the callback
    })
    
  }
  
  func addFirebaseSpriteToOpponentQueue() {
    opponentSpriteQueueRef.childByAutoId().setValue(localPlayerRef.key)
  }
  
}
