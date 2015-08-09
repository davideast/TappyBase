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
    localPlayerRef = TappyBaseConstants.playersRef()
      .childByAppendingPath(match.ref.key)
      .childByAppendingPath(match.localPlayer.id)
    
    // /players/$match/$auth.id
    opponentRef = TappyBaseConstants.playersRef()
      .childByAppendingPath(match.ref.key)
      .childByAppendingPath(match.opponent.playerID)
    
    // /hotPotatoes/$match/$auth.id
    hotPotatoRef = TappyBaseConstants.hotPotatoesRef()
      .childByAppendingPath(match.ref.key)
  }
  
  func listenForHotPotatoes(onHotPotatoAdded: () -> Void) {
    hotPotatoRef.observeEventType(.ChildAdded, withBlock: { snap in
      let id = snap.value as! String
      if id == self.match.localPlayer.id {
        onHotPotatoAdded()
      }
    })
  }
  
  func sendHotPotatoToOpponent() {
    let newPotatoRef = hotPotatoRef.childByAutoId()
    newPotatoRef.onDisconnectRemoveValue()
    newPotatoRef.setValue(match.opponent.playerID)
  }
  
  func gameOver() {
    removeAllValues()
    removeAllObservers()
  }
  
  private func removeAllValues() {
    hotPotatoRef.removeValue()
    localPlayerRef.removeValue()
    opponentRef.removeValue()
    match.ref.removeValue()
  }
  
  private func removeAllObservers() {
    match.ref.removeAllObservers()
    localPlayerRef.removeAllObservers()
    opponentRef.removeAllObservers()
    hotPotatoRef.removeAllObservers()
  }
  
  deinit {
    removeAllObservers()
  }
  
  
}
