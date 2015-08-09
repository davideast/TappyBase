//
//  GameManager.swift
//  TappyBase
//
//  Created by deast on 8/6/15.
//  Copyright (c) 2015 davideast. All rights reserved.
//

import SpriteKit

typealias TappableFirebaseCallback = (sprite: TappableFirebaseSprite) -> Void

class GameManager {
  
  let match: Match
  
  let localPlayerRef: Firebase
  let opponentRef: Firebase
  let hotPotatoRef: Firebase
  
  init(match: Match) {
    
    self.match = match
    
    // /players/$match/$auth.id
    self.localPlayerRef = TappyBaseConstants.playersRef()
      .childByAppendingPath(match.ref.key)
      .childByAppendingPath(match.localPlayer.id)
    
    // /players/$match/$auth.id
    self.opponentRef = TappyBaseConstants.playersRef()
      .childByAppendingPath(match.ref.key)
      .childByAppendingPath(match.opponent.playerID)
    
    // /hotPotatoes/$match/$auth.id
    self.hotPotatoRef = TappyBaseConstants.hotPotatoesRef()
      .childByAppendingPath(match.ref.key)
  }
  
  
  deinit {
    self.match.ref.removeAllObservers()
    self.localPlayerRef.removeAllObservers()
    self.opponentRef.removeAllObservers()
    self.hotPotatoRef.removeAllObservers()
  }
  
  
}
