//
//  Player.swift
//  TappyBase
//
//  Created by deast on 7/27/15.
//  Copyright (c) 2015 davideast. All rights reserved.
//

import GameKit

struct LocalPlayer {
  
  var lives = 3
  var firebaseSpritesTapped = 0
  
  let gkPlayer: GKLocalPlayer!
  let ref: Firebase!
  
  var id: String {
    get {
      return self.gkPlayer.playerID!
    }
  }
  
  var alias: String {
    get {
      return self.gkPlayer.alias!
    }
  }
  
  var displayName: String {
    get {
      return self.gkPlayer.displayName!
    }
  }
  
  var authenticated: Bool {
    get {
      return self.gkPlayer.authenticated
    }
  }
  
  init(localPlayer: GKLocalPlayer!, ref: Firebase? = nil) {
    gkPlayer = localPlayer
    self.ref = ref
  }
  
}