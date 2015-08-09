//
//  TappyBaseConstants.swift
//  TappyBase
//
//  Created by David East on 8/8/15.
//  Copyright (c) 2015 davideast. All rights reserved.
//

import Foundation

struct TappyBaseConstants {
  
  static let FirebaseURL = "https://tappybase.firebaseio.com/"
  static let LobbyURL = "\(FirebaseURL)"
  
  static func rootRef() -> Firebase {
    return Firebase(url: TappyBaseConstants.FirebaseURL)
  }
  
  static func lobbyRef() -> Firebase {
    return rootRef().childByAppendingPath("lobby")
  }
 
  static func playersRef() -> Firebase {
    return rootRef().childByAppendingPath("players")
  }
  
  static func hotPotatoesRef() -> Firebase {
    return rootRef().childByAppendingPath("hotPotatoes")
  }
}