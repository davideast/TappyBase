//
//  Opponent.swift
//  TappyBase
//
//  Created by David East on 8/8/15.
//  Copyright (c) 2015 davideast. All rights reserved.
//

import Foundation

struct Opponent {
  let playerID: String
  let alias: String
  let ref: Firebase
  var lives: Int = 0
  var firebasesTapped: Int = 0
  
  init(snapshot: FDataSnapshot) {
    ref = snapshot.ref
    playerID = snapshot.key
    alias = snapshot.value as! String
  }
  
}
