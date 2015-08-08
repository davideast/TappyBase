//
//  Player.swift
//  TappyBase
//
//  Created by deast on 7/27/15.
//  Copyright (c) 2015 davideast. All rights reserved.
//

import GameKit

struct Player {
  var lives: Int
  var firebaseSpritesTapped: Int
  let gkPlayer = GKLocalPlayer.localPlayer()
}