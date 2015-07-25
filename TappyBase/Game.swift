//
//  Game.swift
//  TappyBase
//
//  Created by deast on 7/16/15.
//  Copyright (c) 2015 davideast. All rights reserved.
//

import Foundation

struct Game {
  
}

struct Player {
  let gameRef: Firebase
  let playersRef: Firebase
  let playerRef: Firebase
  let playerSpritesRef: Firebase
  let playerSpriteRef: Firebase
  let playerName: String
  let userId: String
  
  init(name: String, gameRef: Firebase) {
    self.gameRef = gameRef
    self.playersRef = gameRef.root.childByAppendingPath("players").childByAppendingPath(gameRef.key)
    self.playerRef = self.playersRef.childByAutoId()
    self.userId = self.playerRef.key
    self.playerName = name
    self.playerRef.setValue(name)
    self.playerRef.onDisconnectRemoveValue()
    self.playerSpritesRef = gameRef.childByAppendingPath("playerSprites")
    self.playerSpriteRef = self.playerSpritesRef.childByAppendingPath(self.userId)
  }
  
}